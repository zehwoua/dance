class CreateFavoriteVideos < ActiveRecord::Migration
  def change
    create_table :favorite_videos do |t|
      t.integer :video_id
      t.integer :user_id

      t.timestamps
    end
  end
end
