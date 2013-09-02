class Style < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :videos
end
