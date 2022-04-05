class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization

  around_action :switch_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::DeleteRestrictionError, with: :show_delete_restriction_error
  rescue_from ActiveRecord::RecordNotFound, with: :show_record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name gender date_of_birth])
  end

  def current_account
    account_id = request.headers['account']
    @current_account ||= current_api_user.accounts.find(account_id)
  end

  def pundit_user
    current_api_user
  end

  def show_delete_restriction_error(exception)
    render json: { error: exception.message },
           status: :unprocessable_entity
  end

  def show_record_not_found(exception)
    render json: { error: "#{exception.message} with 'id'=#{params[:id]}" },
           status: :not_found
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    exception_message = I18n.t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

    render json: { error: exception_message },
           status: :forbidden
  end
end
