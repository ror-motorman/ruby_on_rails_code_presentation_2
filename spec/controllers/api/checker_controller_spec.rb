require 'rails_helper'

describe Api::CheckerController do
  before do
    expect(controller).to receive(:restrict_access)
  end

  describe 'GET check_account' do
    let!(:user) { create(:user) }
    let!(:service) { create(:service) }

    it 'returns json "available: true" when user is working with account' do
      account = create(:account, service: service, user: user)

      get :check_account, params: { user_email: user.email, service_name: service.name, account_login: account.login }

      expect(response.body).to eq('{"available":true}')
    end

    it 'returns json "available: false" when user does not work with account' do
      account = create(:account, service: service)

      get :check_account, params: { user_email: user.email, service_name: service.name, account_login: account.login }

      expect(response.body).to eq('{"available":false}')
    end
  end
end
