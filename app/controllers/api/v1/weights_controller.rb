class Api::V1::WeightsController < ApplicationController
  include Sortable
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_weight, only: %i[show update destroy]

  # GET /weights
  def index
    @weights = current_api_user.weights_sorted(sort)
                               .page(current_page)
                               .per(per_page)

    render json: @weights, meta: meta_attributes(@weights), adapter: :json
  end

  # GET /weights/1
  def show
    render json: @weight
  end

  # POST /weights
  def create
    @weight = current_api_user.weights.new(weight_params)

    if @weight.save
      render json: @weight, status: :created
    else
      render json: @weight.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weights/1
  def update
    if @weight.update(weight_params)
      render json: @weight
    else
      render json: @weight.errors, status: :unprocessable_entity
    end
  end

  # DELETE /weights/1
  def destroy
    @weight.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_weight
    @weight = current_api_user.weights.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def weight_params
    params.require(:weight).permit(:date, :value)
  end
end
