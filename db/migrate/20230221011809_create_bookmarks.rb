class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user, foreign_key: true 
      t.references :book_isbn, references: :books, null: false
      t.text :headline, null: false
      t.text :body, null: false
      t.text :page
      t.text :chapter, null: false
      t.text :link

      t.timestamps
    end
    rename_column :bookmarks, :book_isbn_id, :book_isbn
    add_foreign_key :bookmarks, :books, column: :book_isbn, primary_key: 'isbn'
  end
end
