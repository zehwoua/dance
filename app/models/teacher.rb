class Teacher < ActiveRecord::Base
  attr_accessible :name, :profile, :website

  has_many :videos
end
