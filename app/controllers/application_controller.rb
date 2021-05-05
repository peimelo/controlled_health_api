class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name gender date_of_birth])
  end

  def show_not_found_errors(exception)
    render json: { error: "#{exception.message} with 'id'=#{params[:id]}" },
           status: :not_found
  end

  def heights_for_range
    current_api_user.heights_sorted('date', 'desc')
                    .pluck(:date, :value)
  end
end
