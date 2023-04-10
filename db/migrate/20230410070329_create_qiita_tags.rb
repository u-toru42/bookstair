class CreateQiitaTags < ActiveRecord::Migration[7.0]
  def change
    create_table :qiita_tags do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
