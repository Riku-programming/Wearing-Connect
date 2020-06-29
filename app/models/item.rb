class Item < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :classifications
  has_many :coordinates, through: :classifications
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user



  validates :item_name, presence: true
  validates :price, presence: true, length: {maximum: 10}
  mount_uploader :image, ImageUploader



  def self.create_all_ranks
    Item.find(Like.group(:item_id).order(
        Arel.sql('count(item_id) desc')
    ).limit(10).pluck(:item_id))
  end

  def self.search(search)
    return Item.all unless search
    Item.where('title LIKE(?) OR content LIKE(?)', "%#{search}%", "%#{search}%")
  end

  def liked_by?(user_id)
    likes.where(user_id: user_id).exists?
  end
end
