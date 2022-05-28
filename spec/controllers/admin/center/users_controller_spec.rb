# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::Center::UsersController, type: :controller do
  describe '#index' do
    it 'assigns @users' do
      user = User.create(name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456')
      get :index
      expect(assigns('user')).to eq([user])
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    let(:params) { { name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456' } }
    context 'success' do
      it 'create user and redirect_to admin_center_users_path' do
        post :create, params: { user: params }
        expect(User.count).to eq(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(admin_center_users_path)
      end
    end

    context 'failed' do
      it 'if email is NOT uniqueness' do
        User.create(params)
        post :create, params: { user: params }
        expect(User.count).to eq(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_admin_center_user_path)
      end
    end
  end
end
