require 'rails_helper'

describe UsersController do
  let(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    sign_in(admin)
  end

  describe 'GET index' do
    it 'assigns @users and renders the index template' do
      get :index

      expect(assigns(:users)).to eq([user])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns new @user and renders the new template' do
      get :new

      expect(assigns(:user)).to be_new_record
      expect(response).to render_template(:new)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new @user and redirects to the index page' do
        expect do
          post :create, params: { user: attributes_for(:user) }
          expect(response).to redirect_to(action: :index)
        end.to change(User, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not creates a new @user and renders the new template' do
        expect do
          post :create, params: { user: attributes_for(:user, full_name: '') }
          expect(response).to render_template(:new)
        end.to change(User, :count).by(0)
      end
    end
  end

  describe 'GET edit' do
    it 'finds @user and renders the edit template' do
      get :edit, params: { id: user }

      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    let!(:user) { create(:user) }

    context 'with valid attributes' do
      it 'updates @user and redirects to the index page' do
        put :update, params: { id: user, user: { full_name: 'New Name' } }

        user.reload

        expect(user.full_name).to eq('New Name')
        expect(response).to redirect_to(action: :index)
      end
    end

    context 'with invalid attributes' do
      it 'does not updates @user and renders the new template' do
        put :update, params: { id: user, user: { full_name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET work_statistics' do
    let!(:project) { create(:project) }

    it 'assigns @user and @user_work_statistics, then renders the work_statistics template' do
      work_statistic = create(:work_statistic, user: user, project: project)

      get :work_statistics, params: { user_id: user }

      expect(assigns(:user)).to eq(user)
      expect(assigns(:user_work_statistics)).to eq([work_statistic])
      expect(response).to render_template(:work_statistics)
    end
  end

  describe 'GET ban' do
    it 'ban user and redirects to the index page' do
      get :ban, params: { user_id: user }
      user.reload

      expect(user.banned).to be_truthy
      expect(response).to redirect_to(action: :index)
    end

    it 'unlock user when user been banned and redirects to the index page' do
      user.update_attribute(:banned, true)

      get :ban, params: { user_id: user }
      user.reload

      expect(user.banned).to be_falsey
      expect(response).to redirect_to(action: :index)
    end
  end

  describe 'DELETE destroy' do
    it 'destroys @user and redirects to the index page' do
      expect do
        delete :destroy, params: { id: user }
        expect(response).to redirect_to(action: :index)
      end.to change(User, :count).by(-1)
    end
  end
end
