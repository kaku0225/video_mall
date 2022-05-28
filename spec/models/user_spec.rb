# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'insert user' do
    context 'success' do
      it 'if parameter correct' do
        User.create(name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456')
        expect(User.count).to eq(1)
      end
    end

    context 'failed' do
      it 'if name is empty' do
        User.create(email: 'test@test.com', password: '123456', password_confirmation: '123456')
        expect(User.count).to eq(0)
      end

      it 'if email is empty' do
        User.create(name: 'test', password: '123456', password_confirmation: '123456')
        expect(User.count).to eq(0)
      end

      it 'if email format is NOT currect' do
        User.create(name: 'test', email: 'abc', password: '123456', password_confirmation: '123456')
        expect(User.count).to eq(0)
      end

      it 'if email is NOT uniqueness' do
        User.create(name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456')
        User.create(name: 'abcd', email: 'test@test.com', password: '654321', password_confirmation: '654321')
        expect(User.count).to eq(1)
      end

      it 'if password is empty' do
        User.create(name: 'test', email: 'test@test.com')
        expect(User.count).to eq(0)
      end

      it 'if password length is NOT enougth' do
        User.create(name: 'test', email: 'test@test.com', password: '123', password_confirmation: '123')
        expect(User.count).to eq(0)
      end

      it 'if password_confirmation is empty' do
        User.create(name: 'test', email: 'test@test.com', password: '123456')
        expect(User.count).to eq(0)
      end
    end
  end
end
