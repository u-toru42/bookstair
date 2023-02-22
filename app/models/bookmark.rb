# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  book_isbn  :bigint           not null
#  headline   :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_bookmarks_on_book_isbn  (book_isbn)
#  index_bookmarks_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_isbn => books.isbn)
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :book, foreign_key: 'book_isbn'

  validates :headline, presence: true, length: { maximum: 15 }
  validates :body, presence: true, length: { maximum: 105 }
  
  def is_mine?(current_user)
    self.user == current_user
  end
end
