class Comment < ActiveRecord::Base
  attr_accessible :comment_text, 
  				  :video_id

  belongs_to :video
  belongs_to :user
end
