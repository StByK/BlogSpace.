class Post < ApplicationRecord
  has_many :comments
  has_many :images
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :content
  end
end
