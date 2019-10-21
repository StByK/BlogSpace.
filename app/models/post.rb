class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :content
  end

end
