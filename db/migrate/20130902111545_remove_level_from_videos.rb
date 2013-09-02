class RemoveLevelFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :level
  end

  def down
    add_column :videos, :level, :integer
  end
end
