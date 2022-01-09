class Api::V1::DashboardsController < ApplicationController
  include AllHeights

  before_action :authenticate_api_user!
  before_action :current_account

  def index
    @dashboard = Dashboard.new(@current_account, heights_for_range)
    render json: @dashboard, status: :ok
  end
end
