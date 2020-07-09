class AddContentsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :content, :string
  end
end
