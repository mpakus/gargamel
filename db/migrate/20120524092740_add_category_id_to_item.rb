class AddCategoryIdToItem < ActiveRecord::Migration
  def change
    change_table :items do |t|
      unless column_exists? :items, :category_id
        t.integer :category_id
      end
    end
  end
end
