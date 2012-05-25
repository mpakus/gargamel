class Additemidtofile < ActiveRecord::Migration
  def change
    change_table :file_attachment_s3s do |t|
      unless column_exists? :file_attachment_s3s, :item_id
        t.integer :item_id
      end
    end
  end
end
