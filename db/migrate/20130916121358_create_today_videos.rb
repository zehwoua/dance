class CreateTodayVideos < ActiveRecord::Migration
  def change
    create_table :today_videos do |t|
      t.integer :video_id
      t.datetime :set_date

      t.timestamps
    end
  end
end
