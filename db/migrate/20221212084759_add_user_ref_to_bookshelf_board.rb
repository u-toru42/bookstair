class AddUserRefToBookshelfBoard < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookshelf_boards, :user, foreign_key: true
  end
end
