class DropFeeds < ActiveRecord::Migration[7.0]
  def change
    drop_table :feeds do |t|
      t.string :title
      t.text :content
      t.string :url

      t.timestamps
    end
  end
end
