class Review < ApplicationRecord
  belongs_to :book, foreign_key: :isbn
end