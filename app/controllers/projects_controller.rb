class ProjectsController < ApplicationController
  include UsersHelper

  before_action :new_project, only: %i(new create)
  before_action :find_project, only: %i(edit update work_statistics ban destroy work)

  def index
    @projects = current_user.projects
  end

  def new
  end

  def create
    @project.assign_attributes(project_params)
    @project.save ? redirect_to(action: :index) : render(:new)
  end

  def edit
  end

  def update
    @project.update(project_params) ? redirect_to(action: :index) : render(:edit)
  end

  def work_statistics
    @project_work_statistics = @project.work_statistics.includes(:user)
  end

  def ban
    @project.update_attribute(:banned, !@project.banned)
    redirect_to(action: :index)
  end

  def destroy
    @project.destroy
    redirect_to(action: :index)
  end

  def work
    user_work_with_project!(current_user, @project) unless @project.banned
    redirect_to(action: :index)
  end

  private

  def new_project
    @project = Project.new
  end

  def find_project
    @project = Project.find(params[:id] || params[:project_id])
  end

  def project_params
    params.require(:project).permit(:name, account_ids: [], user_ids: [])
  end
end
