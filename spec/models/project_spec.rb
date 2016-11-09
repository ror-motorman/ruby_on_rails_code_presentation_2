require 'rails_helper'

describe Project do
  let(:user) { create(:user) }
  let!(:project) { create(:project) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_and_belong_to_many(:users) }
  it { is_expected.to have_and_belong_to_many(:accounts) }
  it { is_expected.to have_many(:work_statistics) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:account_ids) }
  it { is_expected.to validate_uniqueness_of :name }

  describe '#available?' do
    it 'returns true when project and project accounts has no users' do
      expect(project.available?).to be_truthy
    end

    context 'returns false when project' do
      it 'has user' do
        project.update_attribute(:user, user)
        expect(project.available?).to be_falsey
      end

      it 'account has user' do
        project.accounts.take.update_attribute(:user, user)
        expect(project.available?).to be_falsey
      end
    end
  end
end
