module Api
  class ServicesController < Api::ApplicationController
    serialization_scope :view_context
    respond_to :json

    def index
      render json: Service.all
    end
  end
end
