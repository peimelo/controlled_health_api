class Api::V1::ExamsGraphicsController < ApplicationController
  before_action :authenticate_api_user!
  before_action :current_account

  def show
    results = ExamResult.graphic_values(@current_account, params[:id])
    render json: results, adapter: :json,
           each_serializer: GraphicValuesSerializer, status: :ok
  end
end
