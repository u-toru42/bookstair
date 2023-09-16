# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is invalid without a password' do
      user.password = nil
      expect(user).to_not be_valid
    end
  end

  describe '.guest' do
    it 'creates a guest user if one does not already exist' do
      expect {
        User.guest
      }.to change(User, :count).by(1)
      expect(User.last.email).to eq('guest@example.com')
      expect(User.last.name).to eq('ゲストユーザー')
    end

    it 'retrieves an existing guest user if one already exists' do
      guest_user = User.guest
      expect {
        User.guest
      }.to_not change(User, :count)
    end
  end
end
