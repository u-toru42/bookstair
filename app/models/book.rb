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
<<<<<<< Updated upstream
<<<<<<< Updated upstream
  self.primary_key = :isbn
  has_many :users, primary_key: "isbn", foreign_key: "isbn", through: :bookshelves
  validates :isbn, :uniqueness => {:scope => :isbn}
end
=======
=======
>>>>>>> Stashed changes
  self.primary_key = 'isbn'
  validates :isbn, uniqueness: { scope: :isbn }
  def to_param
    isbn.to_s
  end
  has_many :comments, dependent: :destroy
end
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
