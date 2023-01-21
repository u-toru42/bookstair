class Book < ApplicationRecord
  self.primary_key = :isbn
  has_many :reviews, primary_key: "isbn", foreign_key: "isbn"
end