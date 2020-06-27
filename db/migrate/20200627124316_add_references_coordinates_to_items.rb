class AddReferencesCoordinatesToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :coordinate, foreign_key: true
  end
end
