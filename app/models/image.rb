class Image < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true

  mount_uploaders :image, ImageUploader
end
