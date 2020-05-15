class Item < ApplicationRecord
  has_many :articles
  belongs_to :user
  validates :item_name, presence: true
  validates :price, presence: true, length: {minimum: 1, maximum: 10}

end
