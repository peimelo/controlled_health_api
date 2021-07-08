class Api::V1::ExamsResultsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_result, only: %i[index destroy]
  before_action :set_exam_result, only: %i[destroy]

  def index
    @exam_result = @result.exam_result_sorted(params[:sort], params[:dir])
                          .page(current_page)
                          .per(per_page)

    render json: @exam_result, meta: meta_attributes(@exam_result), adapter: :json
  end

  def destroy
    @exam_result.destroy
  end

  private

  def set_exam_result
    @exam_result = @result.exam_result.find(params[:id])
  end

  def set_result
    @result = current_api_user.results.find(params[:result_id])
  end
end
