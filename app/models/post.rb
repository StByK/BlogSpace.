class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :posts_tag, dependent: :destroy
  has_many :tags, through: :posts_tag
  accepts_nested_attributes_for :tags

  with_options presence: true do
    validates :title
    validates :content
  end


  def save_tags(tag_list)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    exist_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
  
    # Destroy old taggings:
    exist_tags.each do |exist_tag|
      self.tags.delete Tag.find_by(name:exist_tag)
    end

    # Create new taggings:
    new_tags.each do |new_tag|
      post_tag = Tag.find_or_create_by(name:new_tag)
      self.tags << post_tag
    end
  end
end
