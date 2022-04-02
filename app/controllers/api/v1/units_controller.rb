# Class UnitsController
class Api::V1::UnitsController < ApplicationController
  include IsAdmin
  include Paginable

  before_action :authenticate_api_user!
  before_action :is_admin?
  before_action :set_unit, only: %i[show update destroy]

  def index
    @units = Unit.sorted(params[:sort], params[:dir])
                 .page(current_page)
                 .per(per_page)

    render json: @units,
           meta: meta_attributes(@units),
           adapter: :json
  end

  def show
    render json: @unit
  end

  def create
    @unit = Unit.new(unit_params)

    if @unit.save
      render json: @unit, status: :created, location: api_unit_url(@unit)
    else
      render json: @unit.errors, status: :unprocessable_entity
    end
  end

  def update
    if @unit.update(unit_params)
      render json: @unit
    else
      render json: @unit.errors, status: :unprocessable_entity
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
  end
end
