class Level < ActiveRecord::Base
  attr_accessible :name, :scale

  has_many :videos
end
