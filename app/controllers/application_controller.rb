class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :ban_user!, if: -> { current_user&.banned }
  load_and_authorize_resource unless: :devise_controller?

  protected

  def ban_user!
    sign_out(current_user)
    redirect_to(new_user_session_path, alert: t('messages.ban'))
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to(root_url, flash: { error: exception.message })
  end
end
