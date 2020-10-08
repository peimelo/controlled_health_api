class Api::V1::DashboardsController < ApplicationController
  before_action :authenticate_api_user!

  def index
    @dashboard = Dashboard.new(current_api_user)
    render json: @dashboard, status: :ok
  end
end
