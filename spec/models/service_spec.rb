require 'rails_helper'

describe Service do
  let!(:service) { create(:service) }

  it { is_expected.to have_many(:accounts).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:login_button_identifier) }
  it { is_expected.to validate_presence_of(:login_field_identifier) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_uniqueness_of(:url) }
end
