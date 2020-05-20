class AddNumcountToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :favorites_count, :integer
  end
end
