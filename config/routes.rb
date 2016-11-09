Rails.application.routes.draw do
  REGEXP_PARAMETER_WITH_POINT = /[0-z\.]+/

  devise_for :user

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
  end

  resources :users, except: :show do
    get :work_statistics
    get :ban
  end
  resources :services, except: :show
  resources :accounts, except: :show
  resources :projects, except: :show do
    get :work_statistics
    get :ban
    get :work
  end

  root to: 'projects#index'

  namespace :api do
    resources :services, only: :index
    resource :checker, only: [] do
      get 'user/:user_email/service/:service_name/account/:account_login/check_account',
          to: 'checker#check_account',
          constraints: {
            user_email: REGEXP_PARAMETER_WITH_POINT,
            service_name: REGEXP_PARAMETER_WITH_POINT,
            account_login: REGEXP_PARAMETER_WITH_POINT
          },
          as: :check_account
    end
  end
end
