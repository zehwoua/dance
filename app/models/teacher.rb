class Teacher < ActiveRecord::Base
  	attr_accessible :name,
  				  	:profile,
  				  	:website,
  				  	:avatar

  	has_attached_file :avatar,{ 
				:styles => {:medium => "400x400>", :small => "150x150>" },
				:default_url => "http://pixelholdr.com/color:ff5c23/300x300"
				}.merge(PAPERCLIP_STORAGE_OPTIONS)

	# validates_attachment_presence :avatar
	validates_attachment_size :avatar, :less_than => 5.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg','image/jpg', 'image/png']

  has_many :videos

  # Favorited by users
	has_many :favorite_teachers, dependent: :destroy # just the 'relationships'
	has_many :favorited_teacher_by, through: :favorite_teachers, source: :user # the actual users favoriting a teacher
end
