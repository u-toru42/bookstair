class CreateClicks < ActiveRecord::Migration[7.0]
  def change
    create_table :clicks do |t|
      t.references :book_isbn, references: :books, null: false
      t.integer :clicks, defalut: 0, null: false

      t.timestamps
    end
    rename_column :clicks, :book_isbn_id, :book_isbn
    add_foreign_key :clicks, :books, column: :book_isbn, primary_key: 'isbn'
  end
end
