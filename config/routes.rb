require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :dashboards, only: [:index]
      resources :heights
      resources :results
      resources :weights
    end
  end
end
