class AccountsController < ApplicationController
  before_action :account, only: :show

  def index
    @accounts = Account.all
  end

  def show
    @account_operations = account.operations.order(created_at: :desc)
  end

  private

  def account
    @account ||= Account.find(params[:id])
  end
end
