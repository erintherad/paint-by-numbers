class AddAttachmentUrlToPaintings < ActiveRecord::Migration
  def self.up
    change_table :paintings do |t|
      t.attachment :url
    end
  end

  def self.down
    remove_attachment :paintings, :url
  end
end
