class AddScaleToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :scale, :integer, :unique => true
  end
end
