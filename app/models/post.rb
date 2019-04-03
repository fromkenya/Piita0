class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 255 }
  validates :body, presence: true
  belongs_to :user
  has_many :comments
  has_many :stocks
  has_many :likes
end
