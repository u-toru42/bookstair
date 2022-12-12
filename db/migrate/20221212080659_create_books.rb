class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :info_link
      t.string :published_date
      t.string :image_link

      t.timestamps
    end
  end
end
