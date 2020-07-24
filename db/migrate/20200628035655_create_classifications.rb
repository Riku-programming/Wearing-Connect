class CreateClassifications < ActiveRecord::Migration[6.0]
  def change
    create_table :classifications do |t|
      t.references :item, foreign_key: true
      t.references :coordinate, foreign_key: true
      t.timestamps
    end
  end
end
