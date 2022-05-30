# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { User.create(name: 'test', email: 'test@test.com', password: '123456') }
  describe '#index' do
    it 'assigns @users' do
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
    let(:params) { { name: 'test_2', email: 'test_2@test.com', password: '123456' } }
    context 'success' do
      it 'create user and redirect_to root_path' do
        post :create, params: { user: params }
        expect(User.count).to eq(2)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'failed' do
      let(:params) { { name: 'test_2', email: 'test@test.com', password: '123456' } }
      it 'if email is NOT uniqueness' do
        post :create, params: { user: params }
        expect(User.count).to eq(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_path)
      end
    end
  end

  describe '#edit' do
    it 'renders the edit template' do
      get :edit, params: { id: user.id }
      expect(response).to render_template('edit')
      expect(response).to have_http_status(200)
    end
  end

  describe '#update' do
    let(:params) { { name: 'test_2', email: 'test_2@test.com', password: '123456' } }
    context 'success' do
      it 'update user and redirect_to users_path' do
        put :update, params: { id: user.id, user: params }
        user.reload
        expect(user.name).to eq 'test_2'
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(users_path)
      end
    end

    context 'failed' do
      it 'if the email is existed' do
        User.create(params)
        put :update, params: { id: user.id, user: params }
        user.reload
        expect(user.name).to eq 'test'
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(edit_user_path(user))
      end
    end
  end

  describe '#show' do
    it 'renders the show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template('show')
      expect(response).to have_http_status(200)
    end
  end
end
