class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.integer :style_id
      t.integer :duration
      t.integer :teacher_id
      t.integer :level

      t.timestamps
    end
  end
end
