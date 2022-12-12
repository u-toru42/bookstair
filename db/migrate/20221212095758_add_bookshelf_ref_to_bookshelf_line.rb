class AddBookshelfRefToBookshelfLine < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookshelf_lines, :bookshelf, foreign_key: true
  end
end
