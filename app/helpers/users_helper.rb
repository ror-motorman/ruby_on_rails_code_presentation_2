module UsersHelper
  def user_work_with_project!(user, project)
    work_statistic = user.work_statistics.find_or_initialize_by(project: project, end_at: nil)

    if work_statistic.new_record?
      project.update_attribute(:user_id, user.id)
      project.accounts.update_all(user_id: user.id)
      work_statistic.save
    else
      project.update_attribute(:user_id, nil)
      project.accounts.update_all(user_id: nil)
      work_statistic.update_attribute(:end_at, Time.zone.now)
    end
  end

  def user_works_with_project?(user, project)
    user.work_statistics.exists?(project: project, end_at: nil)
  end
end
