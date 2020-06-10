class RemoveUrlFromItems < ActiveRecord::Migration[6.0]
  def change

    remove_column :items, :url, :string
  end
end
