class Api::V1::ExamsResultsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :current_account
  before_action :set_result
  before_action :set_exam_result, only: %i[update destroy]

  def index
    @exam_result = @result.exam_result_sorted(params[:sort], params[:dir])
                          .page(current_page)
                          .per(per_page)

    render json: @exam_result, meta: meta_attributes(@exam_result), adapter: :json
  end

  def create
    @exam_result = @result.exam_result.new(exam_result_params)

    if @exam_result.save
      render json: @exam_result, status: :created
    else
      render json: @exam_result.errors, status: :unprocessable_entity
    end
  end

  def update
    @exam_result.update(exam_result_params)

    if @exam_result.save
      render json: @exam_result, status: :created
    else
      render json: @exam_result.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @exam_result.destroy
  end

  private

  def exam_result_params
    params.require(:exams_result).permit(:value, :exam_id)
  end

  def set_exam_result
    @exam_result = @result.exam_result.find(params[:id])
  end

  def set_result
    @result = @current_account.results.find(params[:result_id])
  end
end
