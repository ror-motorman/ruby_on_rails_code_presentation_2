class AccountsController < ApplicationController
  before_action :new_account, only: %i(new create)
  before_action :find_account, only: %i(edit update destroy)

  def index
    @accounts = Account.includes(:service)
  end

  def new
  end

  def create
    @account.assign_attributes(account_params)
    @account.save ? redirect_to(action: :index) : render(:new)
  end

  def edit
  end

  def update
    @account.update(account_params) ? redirect_to(action: :index) : render(:edit)
  end

  def destroy
    @account.destroy
    redirect_to(action: :index)
  end

  private

  def new_account
    @account = Account.new
  end

  def find_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :url, :login, :password, :note, :service_id)
  end
end
