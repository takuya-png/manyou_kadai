class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
