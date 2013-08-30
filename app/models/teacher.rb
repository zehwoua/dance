class Teacher < ActiveRecord::Base
  	attr_accessible :name,
  				  	:profile,
  				  	:website,
  				  	:avatar

  	has_attached_file :avatar, :styles => {:medium => "300x300>", :small => "150x150>" },
				:default_url => "/assets/default_avatars/default.png",
	            :url  => "/assets/avatars/:id/:style/:basename.:extension",
	            :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"

	# validates_attachment_presence :avatar
	validates_attachment_size :avatar, :less_than => 5.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg','image/jpg', 'image/png']

  has_many :videos
end
