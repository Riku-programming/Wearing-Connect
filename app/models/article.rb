class Article < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :favorites
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :content, presence: true, length: { minimum: 10, maximum: 300 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
