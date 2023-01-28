class Book < ApplicationRecord
  self.primary_key = :isbn
  has_many :users, primary_key: "isbn", foreign_key: "isbn", through: :bookshelves
  validates :isbn, :uniqueness => {:scope => :isbn}
end