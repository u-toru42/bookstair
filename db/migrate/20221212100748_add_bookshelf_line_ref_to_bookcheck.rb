class AddBookshelfLineRefToBookcheck < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookchecks, :bookshelf_line, foreign_key: true
  end
end
