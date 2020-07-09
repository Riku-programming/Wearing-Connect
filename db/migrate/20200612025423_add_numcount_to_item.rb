class AddNumcountToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :likes_count, :integer
  end
end
