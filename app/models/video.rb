class Video < ActiveRecord::Base
	attr_accessible :description,
					  :duration, 
					  :level, 
					  :style_id, 
					  :teacher_id,
					  :level_id, 
					  :title,
					  :photo,
					  :wistia_id

	has_attached_file :photo, :styles => {:medium => "400x400>", :small => "150x150>" },
				:default_url => "/assets/default_avatars/default.png",
	            :url  => "/assets/videos/:id/:style/:basename.:extension",
	            :path => ":rails_root/public/assets/videos/:id/:style/:basename.:extension"
	# validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/jpg', 'image/png']


	#relationships
	has_many :comments, dependent: :destroy
	belongs_to :teacher
	belongs_to :style
	belongs_to :level

	# Favorited by users
	has_many :favorite_videos, dependent: :destroy # just the 'relationships'
	has_many :favorited_by, through: :favorite_videos, source: :user # the actual users favoriting a video
	# Favorited by users
	has_many :history_videos, dependent: :destroy # just the 'relationships'
	has_many :historied_by, through: :history_videos, source: :user # the actual users finish watching a video

end
