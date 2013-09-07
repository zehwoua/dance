class FavoriteVideo < ActiveRecord::Base
  attr_accessible :user_id, :video_id, :user_notes

  belongs_to :video
  belongs_to :user

  scope :most_favorite_videos, select("video_id, count(video_id) as count").group(:video_id).order("count desc").limit(3)
end
