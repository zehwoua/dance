class CreateFavoriteTeachers < ActiveRecord::Migration
  def change
    create_table :favorite_teachers do |t|
      t.integer :user_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
