require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      # uncomment the line below to not allow creating a new account
      # registrations: 'overrides/registrations'
    }

    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :dashboards, only: [:index]
      resources :exams, only: [:index]
      resources :heights
      resources :results do
        resources :exams_results, only: %i[index create update destroy]
      end
      resources :weights
    end
  end
end
