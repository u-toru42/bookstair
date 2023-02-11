# == Schema Information
#
# Table name: books
#
#  author          :string
#  isbn            :bigint           not null, primary key
#  item_url        :text
#  large_image_url :text
#  sales_date      :text
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Book < ApplicationRecord
  self.primary_key = "isbn"
  has_many :comments, dependnet: :destroy
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
