class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :comments, dependnet: :destroy
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end