class AddBookRefToBookAuthor < ActiveRecord::Migration[7.0]
  def change
    add_reference :book_authors, :book, foreign_key: true
  end
end
