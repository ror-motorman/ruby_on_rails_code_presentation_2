class UsersController < ApplicationController
  before_action :new_user, only: %i(new create)
  before_action :find_user, only: %i(edit update work_statistics ban destroy)

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
  end

  def create
    @user.assign_attributes(user_params)
    @user.save ? redirect_to(action: :index) : render(:new)
  end

  def edit
  end

  def update
    @user.update(user_params) ? redirect_to(action: :index) : render(:edit)
  end

  def work_statistics
    @user_work_statistics = @user.work_statistics.includes(:project)
  end

  def ban
    @user.update_attribute(:banned, !@user.banned)
    redirect_to(action: :index)
  end

  def destroy
    @user.destroy
    redirect_to(action: :index)
  end

  private

  def new_user
    @user = User.new
  end

  def find_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def user_params
    params.require(:user).permit(:full_name, :login, :email, :origin_password, :position, :role, project_ids: [])
  end
end
