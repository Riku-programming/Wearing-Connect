class User < ApplicationRecord
  has_many :items
  has_many :favorites
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :friendships
  has_many :friends, through: :friendships
  before_save {self.email = email.downcase}


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.search(param)
    param.strip!
    to_send_back = (name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end

end
