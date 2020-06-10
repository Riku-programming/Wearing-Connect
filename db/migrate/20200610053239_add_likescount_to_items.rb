class AddLikescountToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :like_count, :integer
  end
end
