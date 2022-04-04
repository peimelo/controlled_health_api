class Api::V1::HeightsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :current_account
  before_action :set_height, only: %i[show update destroy]

  # GET /heights
  def index
    @heights = @current_account.heights_sorted(params[:sort], params[:dir])
                               .page(current_page)
                               .per(per_page)

    render json: @heights, meta: meta_attributes(@heights), adapter: :json
  end

  # POST /heights
  def create
    @height = @current_account.heights.new(height_params)

    if @height.save
      render json: @height, status: :created
    else
      render json: @height.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heights/1
  def update
    if @height.update(height_params)
      render json: @height
    else
      render json: @height.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /heights/1
  def destroy
    @height.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_height
    @height = @current_account.heights.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def height_params
    params.require(:height).permit(:date, :value)
  end
end
