require 'rails_helper'

describe Api::ServicesController do
  before do
    expect(controller).to receive(:restrict_access)
  end

  describe 'GET index' do
    it 'returns all services in json' do
      create(
        :service,
        name: 'Test name',
        url: 'http://test.url/',
        login_button_identifier: '#button',
        login_field_identifier: '#login'
      )

      get :index

      expect(response.body).to eq(
        '[{"name":"Test name","url":"http://test.url/",' \
        '"login_button_identifier":"#button","login_field_identifier":"#login"}]'
      )
    end
  end
end
