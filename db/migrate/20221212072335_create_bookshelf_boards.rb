class CreateBookshelfBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :bookshelf_boards do |t|

      t.timestamps
    end
  end
end
