class AddBookshelfRefToBookshelfFollow < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookshelf_follows, :bookshelf, foreign_key: true
  end
end
