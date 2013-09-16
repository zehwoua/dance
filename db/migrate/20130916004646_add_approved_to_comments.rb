class AddApprovedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :approved, :bool
  end
end
