class HistoryVideo < ActiveRecord::Base
  attr_accessible :user_id, :video_id

  belongs_to :video
  belongs_to :user
end
