require 'rails_helper'

describe AccountsHelper do
  let!(:account) { create(:account) }

  describe '#account_status' do
    it 'returns "Free" when account has no user' do
      expect(helper.account_status(account)).to eq('Free')
    end

    it 'returns information about who occupied account when account has user' do
      account.update_attribute(:user, create(:user, full_name: 'Test Name'))
      expect(helper.account_status(account)).to eq('Occupied by Test Name')
    end
  end
end
