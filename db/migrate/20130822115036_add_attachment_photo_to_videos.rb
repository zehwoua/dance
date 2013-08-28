class AddAttachmentPhotoToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :videos, :photo
  end
end
