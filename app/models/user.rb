class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :user_name, presence: true
  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
  has_one_attached :avatar
  has_many :posts
  has_many :comments
  has_many :stocks
  has_many :likes
  mount_uploader :avatar, AvatarUploader
end
