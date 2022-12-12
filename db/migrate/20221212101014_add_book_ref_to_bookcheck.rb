class AddBookRefToBookcheck < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookchecks, :book, foreign_key: true
  end
end
