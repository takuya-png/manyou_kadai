class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks, dependent: :destroy
  enum admin: { 一般: false, 管理者: true }
  validates :password, presence: true, length: { minimum: 6 }
  validates :name,  presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_destroy :lost_admin
  private
  def lost_admin
    if User.where(admin: true).count == 1 && self.admin == "管理者"
      throw(:abort)
    end
  end 
end
