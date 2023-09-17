# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  book_isbn  :bigint           not null
#  chapter    :text
#  headline   :text             not null
#  link       :text
#  page       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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
require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'validations' do
    it 'should validate presence of required fields' do
      should validate_presence_of(:body)
      should validate_presence_of(:headline)
    end

    it 'should validate length of fields' do
      should validate_length_of(:body).is_at_most(3000)
      should validate_length_of(:headline).is_at_most(300)
    end

    it 'should validate numericality of chapter' do
      should validate_numericality_of(:chapter).only_integer.allow_blank
    end

    it 'should validate that content does not contain negative sentiment' do
      # GoogleのAPIをモックして、ネガティブな感情が含まれる場合のテストを書く
      # （Google Cloud Language APIへの実際のリクエストを避けるため）
    end
  end
end
