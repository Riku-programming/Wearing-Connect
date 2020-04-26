class User < ApplicationRecord
  has_many :articles
  has_many :friendships
  has_many :friends, through: :friendships
  before_save {self.email = email.downcase}


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
