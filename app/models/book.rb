# == Schema Information
#
# Table name: books
#
#  author          :string
#  isbn            :bigint           not null, primary key
#  item_price      :string
#  item_url        :text
#  large_image_url :text
#  sales_date      :text
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Book < ApplicationRecord
  self.primary_key = :isbn
  
  has_many :bookmarks, primary_key: 'isbn', foreign_key: 'book_isbn', dependent: :destroy

  validates :isbn, uniqueness: { scope: :isbn }
  
  def to_param
    isbn.to_s
  end
end
