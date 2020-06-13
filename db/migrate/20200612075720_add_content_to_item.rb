class AddContentToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :content, :integer
  end
end
