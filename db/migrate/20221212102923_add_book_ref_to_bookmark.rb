class AddBookRefToBookmark < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookmarks, :book, foreign_key: true
  end
end
