# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  book_isbn  :bigint           not null
#  chapter    :text             not null
#  headline   :text             not null
#  link       :text
#  page       :text
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
  has_many :bookmark_tag_relations, dependent: :destroy
  has_many :tags, through: :bookmark_tag_relations, dependent: :destroy

  validates :headline, presence: true, length: { maximum: 15 }
  validates :body, presence: true, length: { maximum: 105 }
  validates :page, allow_blank: true, length: { maximum: 9999 }
  validates :chapter, allow_blank: true, length: { maximum: 9999 }, numericality: {only_integer: true}
  validates :link, allow_blank: true, numericality: {only_integer: true}

  def is_mine?(current_user)
    self.user == current_user
  end
end
