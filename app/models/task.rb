class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status: search_status)}
  scope :search_priority, -> (search_priority) { where(priority: search_priority)}
  scope :search_label, -> (search_label) { joins(:labels).where(labels: { id: search_label })}
end
