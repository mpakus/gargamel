class Additemidtofile < ActiveRecord::Migration
  def change
    change_table :file_attachment_s3s do |t|
      t.integer :item_id
    end
end
