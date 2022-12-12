class CreateBookshelfLines < ActiveRecord::Migration[7.0]
  def change
    create_table :bookshelf_lines do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
