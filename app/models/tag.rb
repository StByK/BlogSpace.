class Tag < ApplicationRecord
  has_many :posts_tag
  has_many :posts, through: :posts_tag
  validates :name, presence: true, uniqueness: true
end
