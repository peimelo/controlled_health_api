class Api::V1::DashboardsController < ApplicationController
  include AllHeights

  before_action :authenticate_api_user!

  def index
    @dashboard = Dashboard.new(current_api_user, heights_for_range)
    render json: @dashboard, status: :ok
  end
end
