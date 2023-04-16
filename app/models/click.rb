# == Schema Information
#
# Table name: clicks
#
#  id         :bigint           not null, primary key
#  book_isbn  :bigint           not null
#  clicks     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_clicks_on_book_isbn  (book_isbn)
#
# Foreign Keys
#
#  fk_rails_...  (book_isbn => books.isbn)
#
class Click < ApplicationRecord
  belongs_to :book, foreign_key: 'book_isbn' 
end
