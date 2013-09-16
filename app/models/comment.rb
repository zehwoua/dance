class Comment < ActiveRecord::Base
  	attr_accessible :comment_text, 
  				  	:video_id,
  				  	:approved

  	belongs_to :video
  	belongs_to :user

  	scope :latest_comment, order("created_at desc").limit(5)

  	def comment_approved?
	  	return true unless approved != false
	end
end
