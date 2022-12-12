class AddBookshelfBoardRefToBookshelfFollow < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookshelf_follows, :bookshelf_board, foreign_key: true
  end
end
