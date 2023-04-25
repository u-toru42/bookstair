# == Schema Information
#
# Table name: books
#
#  author          :string
#  isbn            :bigint           not null, primary key
#  item_caption    :text
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
  has_many :favorites, primary_key: 'isbn', foreign_key: 'book_isbn', dependent: :destroy
  has_many :users, through: :favorites

  validates :isbn, uniqueness: { scope: :isbn }
  
  def to_param
    isbn.to_s
  end

  # 投稿の並び順なし
  def self.ransackable_attributes(auth_object = nil)
    %w[author created_at isbn item_caption item_price item_url large_image_url sales_date title updated_at]
  end

  # 投稿の並び順あり
  def self.ransackable_associations(auth_object = nil)
    %w[bookmarks]
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end
