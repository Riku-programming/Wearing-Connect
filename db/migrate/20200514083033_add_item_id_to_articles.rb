class AddItemIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :item_id, :integer
  end
end
