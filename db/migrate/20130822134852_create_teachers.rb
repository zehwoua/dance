class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.text :profile
      t.string :website

      t.timestamps
    end
  end
end
