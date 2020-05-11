class Item < ApplicationRecord
  has_many :wants
  belongs_to :user

  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end
end
