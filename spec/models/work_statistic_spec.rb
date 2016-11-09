require 'rails_helper'

describe WorkStatistic do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:project) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:project) }

  it 'sets #start_at time when creating' do
    work_statistic = create(:work_statistic, start_at: nil)
    expect(work_statistic.start_at).not_to be_nil
  end
end
