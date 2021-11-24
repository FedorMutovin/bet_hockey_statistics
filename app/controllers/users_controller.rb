class UsersController < ApplicationController
  def show
    @user_operations = current_user.operations.includes(%i[operational account]).order(created_at: :desc)
    @account = current_user.accounts.first
  end
end
