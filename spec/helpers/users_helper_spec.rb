require 'rails_helper'

describe UsersHelper do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }

  describe '#user_work_with_project!' do
    it 'creates #work_statistic and makes #project and #project accounts unavailable ' \
       'if #user not working with project now' do
      expect do
        helper.user_work_with_project!(user, project)

        work_statistic = user.work_statistics.last

        expect(work_statistic.project).to eq(project)
        expect(work_statistic.end_at).to be_nil
        expect(project.user).to eq(user)
        expect(project.accounts.pluck(:user_id)).to eq([user.id])
      end.to change(WorkStatistic, :count).by(1)
    end

    it 'updates #work_statistic and makes #project and #project accounts available ' \
       'if #user working with project now' do
      helper.user_work_with_project!(user, project)

      expect do
        helper.user_work_with_project!(user, project)

        work_statistic = user.work_statistics.where(project: project).last

        expect(work_statistic.project).to eq(project)
        expect(work_statistic.end_at).not_to be_nil
        expect(project.user).to be_nil
        expect(project.accounts.pluck(:user_id)).to eq([nil])
      end.to change(WorkStatistic, :count).by(0)
    end
  end

  describe '#user_works_with_project?' do
    it 'returns true when #user work with project' do
      helper.user_work_with_project!(user, project)
      expect(helper.user_works_with_project?(user, project)).to be_truthy
    end

    it 'returns true when #user does not work with project' do
      expect(helper.user_works_with_project?(user, project)).to be_falsey
    end
  end
end
