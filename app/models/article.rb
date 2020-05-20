class Article < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :content, presence: true, length: { minimum: 10, maximum: 300 }

  def favorited_by?(user_id)
    favorites.find_by(user_id: user_id)
  end

end
