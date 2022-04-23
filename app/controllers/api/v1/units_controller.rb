# Class UnitsController
class Api::V1::UnitsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_unit, only: %i[update destroy]

  def index
    if params[:page]
      @units = policy_scope(Unit.sorted(params[:sort], params[:dir])
                                .page(current_page)
                                .per(per_page))

      render json: @units, meta: meta_attributes(@units), adapter: :json
    else
      @units = Unit.order(name: :asc)

      render json: @units
    end
  end

  def create
    @unit = Unit.new(unit_params)
    authorize @unit

    if @unit.save
      render json: @unit, status: :created, location: api_unit_url(@unit)
    else
      render json: @unit.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @unit.update(unit_params)
      render json: @unit
    else
      render json: @unit.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @unit.destroy
  end

  private

  def unit_params
    params.require(:unit).permit(:name)
  end

  def set_unit
    @unit = Unit.find(params[:id])
    authorize @unit
  end
end
