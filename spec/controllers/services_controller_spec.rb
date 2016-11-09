require 'rails_helper'

describe ServicesController do
  let(:admin) { create(:admin) }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns @services and renders the index template' do
      service = create(:service)

      get :index

      expect(assigns(:services)).to eq([service])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns new @service and renders the new template' do
      get :new

      expect(assigns(:service)).to be_new_record
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new @service and redirects to the index page' do
        expect do
          post :create, params: { service: attributes_for(:service) }
          expect(response).to redirect_to(action: :index)
        end.to change(Service, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new @service and renders the new template' do
        expect do
          post :create, params: { service: attributes_for(:service, name: '') }
          expect(response).to render_template(:new)
        end.to change(Service, :count).by(0)
      end
    end
  end

  describe 'GET edit' do
    let!(:service) { create(:service) }

    it 'finds @service and renders the edit template' do
      get :edit, params: { id: service }

      expect(assigns(:service)).to eq(service)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    let!(:service) { create(:service) }

    context 'with valid attributes' do
      it 'updates @service and redirects to the index page' do
        put :update, params: { id: service, service: { name: 'New Name' } }

        service.reload

        expect(service.name).to eq('New Name')
        expect(response).to redirect_to(action: :index)
      end
    end

    context 'with invalid attributes' do
      it 'does not updates @service and renders the new template' do
        put :update, params: { id: service, service: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:service) { create(:service) }

    it 'destroys @service and redirects to the index page' do
      expect do
        delete :destroy, params: { id: service.id }
        expect(response).to redirect_to(action: :index)
      end.to change(Service, :count).by(-1)
    end
  end
end
