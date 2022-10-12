class UsersController < ApplicationController
  def profile
    @user_operations = current_user.operations.includes(%i[operational account]).order(created_at: :desc).limit(10)
    @accounts = current_user.accounts.includes(%i[bookmaker operations])
  end
end
