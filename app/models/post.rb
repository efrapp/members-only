class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  scope :order_by_recent, -> { order(created_at: :desc) }
end
