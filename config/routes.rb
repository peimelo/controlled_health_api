require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      # uncomment the line below to not allow creating a new account
      # registrations: 'overrides/registrations'
    }

    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :accounts, except: %i[destroy]
      resources :dashboards, only: %i[index]
      resources :exams, only: %i[index]
      resources :exams_graphics, only: %i[show]
      resources :heights
      resources :results do
        resources :exams_results, only: %i[index create update destroy]
      end
      resources :units, only: %i[create destroy index update]
      resources :weights
    end
  end
end
