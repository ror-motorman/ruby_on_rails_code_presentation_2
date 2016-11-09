require 'rails_helper'

describe AccountsController do
  let(:admin) { create(:admin) }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns @accounts and renders the index template' do
      account = create(:account)

      get :index

      expect(assigns(:accounts)).to eq([account])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns new @account and renders the new template' do
      get :new

      expect(assigns(:account)).to be_new_record
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new @account and redirects to the index page' do
        expect do
          post :create, params: { account: attributes_for(:account) }
          expect(response).to redirect_to(action: :index)
        end.to change(Account, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new @account and renders the new template' do
        expect do
          post :create, params: { account: attributes_for(:account, name: '') }
          expect(response).to render_template(:new)
        end.to change(Account, :count).by(0)
      end
    end
  end

  describe 'GET edit' do
    let!(:account) { create(:account) }

    it 'finds @account and renders the edit template' do
      get :edit, params: { id: account }

      expect(assigns(:account)).to eq(account)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    let!(:account) { create(:account) }

    context 'with valid attributes' do
      it 'updates @account and redirects to the index page' do
        put :update, params: { id: account, account: { name: 'New Name' } }

        account.reload

        expect(account.name).to eq('New Name')
        expect(response).to redirect_to(action: :index)
      end
    end

    context 'with invalid attributes' do
      it 'does not updates @account and renders the new template' do
        put :update, params: { id: account, account: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:account) { create(:account) }

    it 'destroys @account and redirects to the index page' do
      expect do
        delete :destroy, params: { id: account.id }
        expect(response).to redirect_to(action: :index)
      end.to change(Account, :count).by(-1)
    end
  end
end
