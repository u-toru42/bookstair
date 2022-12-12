class AddBookRefToReview < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :book, foreign_key: true
  end
end
