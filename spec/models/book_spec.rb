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
