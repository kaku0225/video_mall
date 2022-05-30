# frozen_string_literal: true

# user controller
class UsersController < ApplicationController
  before_action :find_user, only: %i[edit show update]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!
    flash[:notice] = '新增成功'
    redirect_to root_path
  rescue StandardError => e
    flash[:alert] = e
    redirect_to new_user_path
  end

  def edit; end

  def update
    @user.update!(user_params)
    flash[:notice] = '更新成功'
    redirect_to users_path
  rescue StandardError => e
    flash[:alert] = e
    redirect_to edit_user_path(@user)
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
