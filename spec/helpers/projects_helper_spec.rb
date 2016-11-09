require 'rails_helper'

describe ProjectsHelper do
  let!(:project) { create(:project) }

  describe '#project_status' do
    it 'returns "Blocked" when project banned' do
      project.update_attribute(:banned, true)
      expect(helper.project_status(project)).to eq('Blocked')
    end

    it 'returns "Free" when project available' do
      expect(helper.project_status(project)).to eq('Free')
    end

    it 'returns information about who occupied project when project has user' do
      user = create(:user)
      project.update_attribute(:user, user)

      user.update_attribute(:full_name, 'Test Name')

      expect(helper.project_status(project)).to eq('Occupied by Test Name')
    end

    it 'returns "No available accounts" when project unavailable and has no user' do
      user = create(:user)

      project.accounts.take.update_attribute(:user, user)

      expect(helper.project_status(project)).to eq('No available accounts')
    end
  end
end
