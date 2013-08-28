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

  	has_many :comments

  	# Favorite videos of user
  	has_many :favorite_videos # just the 'relationships'
  	has_many :favorites, through: :favorite_videos, source: :video # the actual videos user favorites

  	validates :username, presence: { :on => :create }
  	validates :email, presence: { :on => :create }
  	validates :email, :email_format => true 
	validates_length_of :password, :minimum => 4
	validates_uniqueness_of :email
	validates_uniqueness_of :username, :if => :username_present?
	validates_presence_of :password_confirmation, :if => :password_present?
	validates_confirmation_of :password, :if => :password_present?

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
end
