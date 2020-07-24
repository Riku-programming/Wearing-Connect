class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :coordinates

  has_many :likes, dependent: :destroy
  has_many :likes_items, through: :likes, source: :item

  has_many :active_relationships, class_name:
      "Friendship", foreign_key:
               :following_id, dependent:
               :destroy

  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name:
      "Friendship", foreign_key:
               :follower_id, dependent:
               :destroy
  has_many :followers, through: :passive_relationships, source: :following
  mount_uploader :avatar, ImageUploader


  validates :name, presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  before_save { self.email = email.downcase }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: {
                with: VALID_EMAIL_REGEX
            }
  validates :password,
            presence: true,
            length: { minimum: 8 }
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
    matches("name", param)
  end

  def self.email_matches(param)
    matches("email", param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_follows_with?(user)
    !self.followings.where(id: user).exists?
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def update_with_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end
end
