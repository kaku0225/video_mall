# frozen_string_literal: true

module Admin
  # from center
  module Center
    # user controller
    class UsersController < ApplicationController
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
        redirect_to admin_center_users_path
      rescue StandardError => e
        flash[:alert] = e
        redirect_to new_admin_center_user_path
      end

      private

      def user_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
      end
    end
  end
end
