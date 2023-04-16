class AddDefaultToClicksInClicks < ActiveRecord::Migration[7.0]
  def up
    change_column_default :clicks, :clicks, 0
  end

  def down
    change_column_default :clicks, :clicks, nil
  end
end
