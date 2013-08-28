class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :video_id
      t.text :comment_text
      t.belongs_to :user
      t.belongs_to :video

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :video_id
  end
end
