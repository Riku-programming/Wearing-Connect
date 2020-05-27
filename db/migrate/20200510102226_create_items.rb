class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :item_name
      t.integer :price
      t.string :url
      t.timestamps


    end
  end
end
