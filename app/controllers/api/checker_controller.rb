module Api
  class CheckerController < Api::ApplicationController
    respond_to :json

    def check_account
      render json: {
        available: Account.joins(:user).joins(:service).where(
          'users.email = ? AND services.name = ? AND accounts.login = ?',
          params[:user_email], params[:service_name], params[:account_login]
        ).any?
      }
    end
  end
end
