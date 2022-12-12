class CreateBookAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :book_authors do |t|

      t.timestamps
    end
  end
end
