module IsAdmin
  protected

  def is_admin?
    render json: { error: 'Permission denied.' },
           status: :forbidden unless current_api_user.admin?
    end
end
