class CreateBookmarkTagRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmark_tag_relations do |t|
      t.references :bookmark, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
