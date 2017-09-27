class AddAttachmentSmallImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :small_image
    end
  end

  def self.down
    remove_attachment :posts, :small_image
  end
end
