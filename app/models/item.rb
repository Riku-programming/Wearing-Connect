class Item < ApplicationRecord
  has_many :wants
  belongs_to :user
  validates :item_name, presence: true
  validates :price, presence: true, length: {minimum: 1, maximum: 10}

  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end
end
