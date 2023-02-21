class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, foreign_key: true 
      t.references :book_isbn, references: :books, null: false
      t.text :body, null: false

      t.timestamps
    end
    rename_column :comments, :book_isbn_id, :book_isbn
    add_foreign_key :comments, :books, column: :book_isbn, primary_key: 'isbn'
  end
end
