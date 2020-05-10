class CreateWants < ActiveRecord::Migration[6.0]
  def change
    create_table :wants do |t|
      t.integer :user_id
      t.integer :item_id

      t.index [:user_id, :item_id], unique: true
      t.timestamps
    end
  end
end
