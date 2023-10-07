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
# book_spec.rb

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      book = build(:book)
      expect(book).to be_valid
    end
  end
end
