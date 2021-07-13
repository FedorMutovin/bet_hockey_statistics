class UsersController < ApplicationController
  before_action :user, only: :show

  def index
    @users = User.all
  end

  def show
    @user_operations = user.operations.order(created_at: :desc)
    @games = Game.all
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
