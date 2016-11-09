require 'rails_helper'

describe Account do
  let!(:account) { create(:account) }

  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_and_belong_to_many(:projects) }

  it { is_expected.to validate_presence_of(:service_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:login) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of :name }
end
