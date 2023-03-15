class AddBookmarksToReviewStars < ActiveRecord::Migration[7.0]
  def change
    add_column :bookmarks, :review_star, :integer
  end
end
