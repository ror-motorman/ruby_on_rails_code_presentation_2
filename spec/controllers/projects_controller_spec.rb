require 'rails_helper'

describe ProjectsController do
  describe 'for admin' do
    let(:admin) { create(:admin) }
    let!(:project) { create(:project) }

    before do
      sign_in(admin)
    end

    describe 'GET index' do
      it 'assigns @projects and renders the index template' do
        get :index

        expect(assigns(:projects)).to eq([project])
        expect(response).to render_template(:index)
      end
    end

    describe 'GET new' do
      it 'assigns new @project and renders the new template' do
        get :new

        expect(assigns(:project)).to be_new_record
        expect(response).to render_template(:new)
      end
    end

    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new @project and redirects to the index page' do
          expect do
            post :create, params: { project: attributes_for(:project) }
            expect(response).to redirect_to(action: :index)
          end.to change(Project, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not creates a new @project and renders the new template' do
          expect do
            post :create, params: { project: attributes_for(:project, name: '') }
            expect(response).to render_template(:new)
          end.to change(Project, :count).by(0)
        end
      end
    end

    describe 'GET edit' do
      it 'finds @project and renders the edit template' do
        get :edit, params: { id: project }

        expect(assigns(:project)).to eq(project)
        expect(response).to render_template(:edit)
      end
    end

    describe 'PUT update' do
      let!(:project) { create(:project) }

      context 'with valid attributes' do
        it 'updates @project and redirects to the index page' do
          put :update, params: { id: project, project: { name: 'New Name' } }

          project.reload

          expect(project.name).to eq('New Name')
          expect(response).to redirect_to(action: :index)
        end
      end

      context 'with invalid attributes' do
        it 'does not updates @project and renders the new template' do
          put :update, params: { id: project, project: { name: '' } }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'GET work_statistics' do
      it 'assigns @project and @project_work_statistics, then renders the work_statistics template' do
        work_statistic = create(:work_statistic, user: admin, project: project)

        get :work_statistics, params: { project_id: project }

        expect(assigns(:project)).to eq(project)
        expect(assigns(:project_work_statistics)).to eq([work_statistic])
        expect(response).to render_template(:work_statistics)
      end
    end

    describe 'GET ban' do
      it 'ban project and redirects to the index page' do
        get :ban, params: { project_id: project }
        project.reload

        expect(project.banned).to be_truthy
        expect(response).to redirect_to(action: :index)
      end

      it 'unlock project when project been banned and redirects to the index page' do
        project.update_attribute(:banned, true)

        get :ban, params: { project_id: project }
        project.reload

        expect(project.banned).to be_falsey
        expect(response).to redirect_to(action: :index)
      end
    end

    describe 'DELETE destroy' do
      it 'destroys @project and redirects to the index page' do
        expect do
          delete :destroy, params: { id: project }
          expect(response).to redirect_to(action: :index)
        end.to change(Project, :count).by(-1)
      end
    end

    describe 'GET work' do
      it 'does not creates work_statistics when project banned and redirects to the index page' do
        project.update_attribute(:banned, true)

        get :work, params: { project_id: project }
        project.reload

        expect(project.work_statistics).to eq([])
        expect(response).to redirect_to(action: :index)
      end
    end
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let!(:user_project) { create(:project, user_ids: [user.id]) }

    before do
      sign_in(user)
    end

    describe 'GET index' do
      it 'assigns user @projects and renders the index template' do
        create(:project)

        get :index

        expect(assigns(:current_user)).to eq(user)
        expect(Project.count).to eq(2)
        expect(assigns(:projects)).to eq([user_project])
        expect(response).to render_template(:index)
      end
    end
  end
end
