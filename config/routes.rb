require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'

    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :dashboards, only: [:index]
      resources :heights
      resources :results do
        resources :exams_results, only: [:index]
      end
      resources :weights
    end
  end
end
