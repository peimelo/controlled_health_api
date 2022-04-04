# Class ReferencesController
class Api::V1::ReferencesController < ApplicationController
  include IsAdmin
  include Paginable

  before_action :authenticate_api_user!
  before_action :is_admin?
  before_action :set_reference, only: %i[show update destroy]

  def index
    @references = Reference.sorted(params[:sort], params[:dir])
                      .page(current_page)
                      .per(per_page)

    render json: @references,
           meta: meta_attributes(@references),
           adapter: :json
  end

  def create
    @reference = Reference.new(reference_params)

    if @reference.save
      render json: @reference, status: :created, location: api_reference_url(@reference)
    else
      render json: @reference.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @reference.update(reference_params)
      render json: @reference
    else
      render json: @reference.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @reference.destroy
  end

  private

  def reference_params
    params.require(:reference).permit(:name)
  end

  def set_reference
    @reference = Reference.find(params[:id])
  end
end
