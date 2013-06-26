class AddAttachmentPostimageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :postimage
    end
  end

  def self.down
    drop_attached_file :posts, :postimage
  end
end
