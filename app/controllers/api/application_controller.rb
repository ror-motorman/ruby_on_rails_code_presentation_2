module Api
  class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    ACCESS_TOKEN = 'c060732e98f0680887f20233b2a8f0f5'.freeze

    before_action :restrict_access

    private

    def restrict_access
      authenticate_or_request_with_http_token do |token, _options|
        token == ACCESS_TOKEN
      end
    end
  end
end
