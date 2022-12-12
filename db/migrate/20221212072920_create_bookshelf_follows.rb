class CreateBookshelfFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :bookshelf_follows do |t|

      t.timestamps
    end
  end
end
