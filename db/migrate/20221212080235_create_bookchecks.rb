class CreateBookchecks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookchecks do |t|

      t.timestamps
    end
  end
end
