class Coordinate < ApplicationRecord
  belongs_to :user
  has_many :classifications
  has_many :items, through: :classifications, dependent: :destroy
  accepts_nested_attributes_for :classifications, allow_destroy: true

  validates :name, presence: true
end
