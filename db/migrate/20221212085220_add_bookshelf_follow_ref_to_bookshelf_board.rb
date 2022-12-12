class AddBookshelfFollowRefToBookshelfBoard < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookshelf_boards, :bookshelf_follow, foreign_key: true
  end
end
