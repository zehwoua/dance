class AddUserNotesToFavoriteVideos < ActiveRecord::Migration
  def change
    add_column :favorite_videos, :user_notes, :text
  end
end
