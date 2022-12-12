class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :status
      t.integer :comprehension

      t.timestamps
    end
  end
end
