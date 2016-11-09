require 'rails_helper'

describe User do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  it { is_expected.to have_many(:accounts) }
  it { is_expected.to have_many(:occupied_projects) }
  it { is_expected.to have_many(:work_statistics) }
  it { is_expected.to have_and_belong_to_many(:projects) }

  it { is_expected.to define_enum_for(:role).with(User::ROLES) }

  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_presence_of(:login) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:origin_password) }
  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_length_of(:origin_password).is_at_least(8) }
  it { is_expected.to validate_uniqueness_of(:login) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it 'sets new #password when #origin_password changed' do
    old_encrypted_password = user.encrypted_password

    user.update(origin_password: 'test_password')

    expect(user.encrypted_password).not_to eq(old_encrypted_password)
  end

  it 'sets new #origin_password when #password updated' do
    new_password = 'test_password'

    user.update(password: new_password)

    expect(user.origin_password).to eq(new_password)
  end

  it 'sets #role "user" when role blank' do
    user = User.new
    expect(user.role).to eq('user')
  end

  describe '#projects' do
    let!(:project) { create(:project) }
    let!(:user_project) { create(:project, users: [user]) }

    it 'returns all projects for admin' do
      expect(admin.projects).to eq([project, user_project])
    end

    it 'returns only user projects for user' do
      expect(user.projects).to eq([user_project])
    end
  end

  describe 'abilities' do
    context 'when admin' do
      subject(:ability) { Ability.new(admin) }

      it { is_expected.to be_able_to(:manage, :all) }
    end

    context 'when user' do
      subject(:ability) { Ability.new(user) }

      it { is_expected.to be_able_to(:index, Project) }
      it { is_expected.to be_able_to(:work, Project) }
    end
  end
end
