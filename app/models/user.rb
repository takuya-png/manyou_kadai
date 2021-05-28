class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks
  enum admin: { 一般: false, 管理者: true }
  validates :password, presence: true, length: { minimum: 6 }
  validates :name,  presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
