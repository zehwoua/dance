class AddLevelIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :level_id, :integer
  end
end
