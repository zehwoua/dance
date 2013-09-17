class TodayVideo < ActiveRecord::Base
  attr_accessible :set_date, :video_id

  validates_presence_of :video_id

  belongs_to :video
end
