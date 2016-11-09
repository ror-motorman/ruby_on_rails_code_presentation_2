class ServicesController < ApplicationController
  before_action :new_service, only: %i(new create)
  before_action :find_service, only: %i(edit update destroy)

  def index
    @services = Service.all
  end

  def new
  end

  def create
    @service.assign_attributes(service_params)
    @service.save ? redirect_to(action: :index) : render(:new)
  end

  def edit
  end

  def update
    @service.update(service_params) ? redirect_to(action: :index) : render(:edit)
  end

  def destroy
    @service.destroy
    redirect_to(action: :index)
  end

  private

  def new_service
    @service = Service.new
  end

  def find_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :url, :login_button_identifier, :login_field_identifier)
  end
end
