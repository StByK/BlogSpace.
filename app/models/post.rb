class Post < ApplicationRecord
  has_many :comments
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :content
  end
end
