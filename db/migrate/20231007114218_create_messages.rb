class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.datetime :published
      t.text :sender
      t.text :content

      t.timestamps
    end
  end
end
