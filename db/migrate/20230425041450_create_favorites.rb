class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.references :book_isbn, references: :books, null: false

      t.timestamps
    end
    rename_column :favorites, :book_isbn_id, :book_isbn
    add_foreign_key :favorites, :books, column: :book_isbn, primary_key: 'isbn'
    add_index :favorites, [:user_id, :book_isbn], unique: true
  end
end
