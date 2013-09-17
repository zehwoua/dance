class FavoriteTeacher < ActiveRecord::Base
  attr_accessible :teacher_id, :user_id

  belongs_to :teacher
  belongs_to :user
end
