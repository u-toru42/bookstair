class Comment < ApplicationRecord
  # belongs_to :user
  # belongs_to :book, primary_key: "isbn"
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
  # belongs_to :isbn, primary_key: "isbn"
  validates :name, presence: true, length: { maximum: 10 }
  validates :comment, presence: true, length: { maximum: 105 }
  def is_mine?(current_user)
    self.user == current_user
  end
end