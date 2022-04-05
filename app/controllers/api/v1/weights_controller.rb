class Api::V1::WeightsController < ApplicationController
  include AllHeights
  include Paginable

  before_action :authenticate_api_user!
  before_action :current_account
  before_action :set_weight, only: %i[update destroy]

  # GET /weights
  def index
    @weights = @current_account.weights_sorted(params[:sort], params[:dir])
                               .page(current_page)
                               .per(per_page)

    render json: @weights,
           meta: meta_attributes(@weights),
           adapter: :json,
           heights_for_range: heights_for_range
  end

  # POST /weights
  def create
    @weight = @current_account.weights.new(weight_params)

    if @weight.save
      render json: @weight, status: :created
    else
      render json: @weight.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weights/1
  def update
    if @weight.update(weight_params)
      render json: @weight
    else
      render json: @weight.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /weights/1
  def destroy
    @weight.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_weight
    @weight = @current_account.weights.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def weight_params
    params.require(:weight).permit(:date, :value)
  end
end
