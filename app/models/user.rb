class User < ActiveRecord::Base
	FIELDS = [:first_name, :last_name, :phone, :website, :company, :fax, :addresses, :credit_cards, :custom_fields]

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	# Setup accessible (or protected) attributes for your model
	attr_accessor *FIELDS
	attr_accessor :plan_id
	attr_accessible :email,
					:password, 
					:password_confirmation, 
					:remember_me, 
					:username,
					:avatar,
					:braintree_customer_id,
					:admin,
					:customer_type

	# attr_accessible :title, :body

	has_attached_file :avatar, { 
				:styles => {:medium => "400x400>", :small => "150x150>" },
				:default_url => "http://pixelholdr.com/color:ff5c23/150x150"
				}.merge(PAPERCLIP_STORAGE_OPTIONS)

	# validates_attachment_presence :avatar
	validates_attachment_size :avatar, :less_than => 5.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg','image/jpg', 'image/png']

  	has_many :comments, dependent: :destroy

  	# Favorite videos of user
  	has_many :favorite_videos, dependent: :destroy # just the 'relationships'
  	has_many :favorites, through: :favorite_videos, source: :video # the actual videos user favorites

  	# Favorite teachers of user
  	has_many :favorite_teachers, dependent: :destroy # just the 'relationships'
  	has_many :favorites_teacher, through: :favorite_teachers, source: :teacher # the actual teacher user favorites

  	# History videos of user
  	has_many :history_videos, dependent: :destroy # just the 'relationships'
  	has_many :histories, through: :history_videos, source: :video # the actual videos user favorites

  	validates :username, presence: { :on => :create }
 #  	validates :email, :presence => true,
 #                                    :if => :validate_password?,
 #                                    :confirmation => true,
 #                                    :length       => { :within => 6..40 }
 #  	validates :email, :email_format => true 
	# validates_uniqueness_of :email
	validates_uniqueness_of :username, :if => :username_present?
	# validates_presence_of :password_confirmation, :if => :password_present?
	# validates_confirmation_of :password, :if => :password_present?

	after_destroy :destroy_customer

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_create do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.username = auth.info.nickname
	  end
	end

	def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end
	end

	def password_required?
	  super && provider.blank?
	end

	def update_with_password(params, *options)
	  if encrypted_password.blank?
	    update_attributes(params, *options)
	  else
	    super
	  end
	end



	def validate_password?
		if new_record?
	    	return true
	  	else
		    if password.to_s.empty?
		      	return false
		    else
		      	return true
		    end
		end
	end
	def username_present?
		username.nil?
	end

	def password_present?
	  !password.nil?
	end

  	def has_payment_info?
	    !!braintree_customer_id
	end

	def paid_customer?
		!customer_type == 'paid'
	end


	def with_braintree_data!
	    return self unless has_payment_info?
	    # braintree_data = Braintree::Customer.find(braintree_customer_id)

	    customer = Braintree::Customer.find(braintree_customer_id)

	    FIELDS.each do |field|
	      send(:"#{field}=", customer.send(field))
	    end
	    self
	end

	def default_credit_card
	    return unless has_payment_info?

	    credit_cards.find { |cc| cc.default? }
	end

	def full_name
	  	"#{first_name} #{last_name}"
	end

	def customer
	    braintree_customer_id && BraintreeRails::Customer.new(braintree_customer_id)
	end

	private
	def destroy_customer
	    BraintreeRails::Customer.delete(braintree_customer_id) if braintree_customer_id.present?
	end

end
