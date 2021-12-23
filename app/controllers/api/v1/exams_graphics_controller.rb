class Api::V1::ExamsGraphicsController < ApplicationController
  before_action :authenticate_api_user!

  def show
    results = ExamResult.graphic_values(current_api_user, params[:id])
    render json: results, adapter: :json,
           each_serializer: GraphicValuesSerializer, status: :ok
  end
end
