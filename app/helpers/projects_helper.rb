module ProjectsHelper
  def project_status(project)
    return t('helpers.status.blocked') if project.banned
    return t('helpers.status.free') if project.available?
    project.user_id? ? t('helpers.status.occupied_by', name: project.user.full_name) : t('helpers.status.occupied')
  end
end
