class AddBookmarksToCodeBlocks < ActiveRecord::Migration[7.0]
  def change
    add_column :bookmarks, :code_block, :text
  end
end
