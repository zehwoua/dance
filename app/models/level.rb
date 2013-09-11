class Level < ActiveRecord::Base
  attr_accessible :name, :scale

  has_many :videos
  validates_presence_of :name, :scale
  validates_uniqueness_of :scale
end
