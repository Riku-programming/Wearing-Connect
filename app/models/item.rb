class Item < ApplicationRecord
  has_many :articles
  belongs_to :user
  validates :item_name, presence: true
  validates :price, presence: true, length: {maximum: 10}
  mount_uploader :image, ImageUploader

end
