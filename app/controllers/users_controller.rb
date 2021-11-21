class UsersController < ApplicationController
  before_action :user, only: :show

  def index
    @users = User.all
    @user = User.last
  end

  def show
    @user_operations = user.operations.includes(%i[operational account]).order(created_at: :desc)
    @account = @user.accounts.first
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
