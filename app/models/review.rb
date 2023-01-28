class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book, foreign_key: :isbn

  validates :body, presence: true, length: { maximum: 65_535 }
end