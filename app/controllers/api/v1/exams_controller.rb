class Api::V1::ExamsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_exam, only: %i[update destroy]

  def index
    if params[:page].present?
      @exams = policy_scope(Exam.includes(:unit).sorted(params[:sort], params[:dir])
                                .page(current_page)
                                .per(per_page))

      render json: @exams, meta: meta_attributes(@exams), adapter: :json
    else
      @exams = Exam.includes(:unit).order(name: :asc)

      render json: @exams
    end
  end

  def update
    if @exam.update(exam_params)
      render json: @exam
    else
      render json: @exam.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:name, :unit_id)
  end

  def set_exam
    @exam = Exam.find(params[:id])
    authorize @exam
  end
end
