class User < ActiveRecord::Base
	FIELDS = [:first_name, :last_name, :phone, :website, :company, :fax, :addresses, :credit_cards, :custom_fields]

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessor *FIELDS
	attr_accessible :email,
					:password, 
					:password_confirmation, 
					:remember_me, 
					:username,
					:avatar,
					:braintree_customer_id
	# attr_accessible :title, :body

	has_attached_file :avatar, :styles => {:medium => "300x300>", :small => "150x150>" },
				:default_url => "/assets/default_avatars/default.png",
	            :url  => "/assets/avatars/:id/:style/:basename.:extension",
	            :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"

	# validates_attachment_presence :avatar
	validates_attachment_size :avatar, :less_than => 5.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg','image/jpg', 'image/png']

  	has_many :comments, dependent: :destroy

  	# Favorite videos of user
  	has_many :favorite_videos, dependent: :destroy # just the 'relationships'
  	has_many :favorites, through: :favorite_videos, source: :video # the actual videos user favorites

  	# History videos of user
  	has_many :history_videos, dependent: :destroy # just the 'relationships'
  	has_many :histories, through: :history_videos, source: :video # the actual videos user favorites

 #  	validates :username, presence: { :on => :create }
 #  	validates :email, :presence => true,
 #                                    :if => :validate_password?,
 #                                    :confirmation => true,
 #                                    :length       => { :within => 6..40 }
 #  	validates :email, :email_format => true 
	# validates_uniqueness_of :email
	# validates_uniqueness_of :username, :if => :username_present?
	# validates_presence_of :password_confirmation, :if => :password_present?
	# validates_confirmation_of :password, :if => :password_present?

	after_destroy :destroy_customer

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
