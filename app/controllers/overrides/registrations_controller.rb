module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    def create
      render json: {
        success: false,
        errors: ['It is no longer possible to create an account.']
      }, status: 401
    end
  end
end
