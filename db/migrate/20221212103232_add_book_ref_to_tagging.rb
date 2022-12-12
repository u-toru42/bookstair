class AddBookRefToTagging < ActiveRecord::Migration[7.0]
  def change
    add_reference :taggings, :book, foreign_key: true
  end
end
