class CreateFileAttachmentS3s < ActiveRecord::Migration
  def change
    create_table :file_attachment_s3s do |t|
      t.integer :item_id

      t.timestamps
    end
  end
end
