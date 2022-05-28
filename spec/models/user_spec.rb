# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'insert user' do
    let(:params) { { name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456' } }
    context 'success' do
      it 'if parameter correct' do
        User.create(params)
        expect(User.count).to eq(1)
      end
    end

    context 'failed' do
      it 'if name is empty' do
        params[:name] = nil
        User.create(params)
        expect(User.count).to eq(0)
      end

      it 'if email is empty' do
        params[:email] = nil
        User.create(name: 'test', password: '123456', password_confirmation: '123456')
        expect(User.count).to eq(0)
      end

      it 'if email format is NOT currect' do
        params[:email] = 'abc'
        User.create(params)
        expect(User.count).to eq(0)
      end

      it 'if email is NOT uniqueness' do
        2.times do
          User.create(params)
        end
        expect(User.count).to eq(1)
      end

      it 'if password is empty' do
        params[:password] = nil
        User.create(params)
        expect(User.count).to eq(0)
      end

      it 'if password length is NOT enougth' do
        params[:password] = '123'
        User.create(params)
        expect(User.count).to eq(0)
      end

      it 'if password_confirmation is empty' do
        params[:password_confirmation] = nil
        User.create(params)
        expect(User.count).to eq(0)
      end
    end
  end
end
