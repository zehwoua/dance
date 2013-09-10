class Style < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :videos
  validates_presence_of :name, :description
end
