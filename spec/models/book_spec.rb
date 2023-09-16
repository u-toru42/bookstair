require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      book = build(:book)
      expect(book).to be_valid
    end

    # it 'is not valid without an ISBN' do
    #   book = build(:book, isbn: nil)
    #   expect(book).to_not be_valid
    # end

    # it 'is not valid with duplicate ISBN' do
    #   create(:book, isbn: '1234567890123')
    #   book = build(:book, isbn: '1234567890123')
    #   expect(book).to_not be_valid
    # end
  end

  # describe 'Associations' do
  #   it { should have_many(:bookmarks).with_foreign_key('book_isbn').dependent(:destroy) }
  #   it { should have_many(:favorites).with_foreign_key('book_isbn').dependent(:destroy) }
  #   it { should have_many(:favorite_users).through(:favorites).source(:user) }
  # end
end
