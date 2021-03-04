class Api::V1::ResultsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_result, only: %i[show update destroy]

  # GET /results
  def index
    @results = current_api_user.results_sorted(params[:sort], params[:dir])
                               .page(current_page)
                               .per(per_page)

    render json: @results, meta: meta_attributes(@results), adapter: :json
  end

  # GET /results/1
  def show
    render json: @result
  end

  # POST /results
  def create
    @result = current_api_user.results.new(result_params)

    if @result.save
      render json: @result, status: :created
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /results/1
  def update
    if @result.update(result_params)
      render json: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # DELETE /results/1
  def destroy
    @result.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_result
    @result = current_api_user.results.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def result_params
    params.require(:result).permit(:date, :value)
  end
end
