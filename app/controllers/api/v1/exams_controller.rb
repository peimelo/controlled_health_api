class Api::V1::ExamsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!

  def index
    if params[:page]
      @exams = policy_scope(Exam.includes(:unit).sorted(params[:sort], params[:dir])
                                .page(current_page)
                                .per(per_page))

      render json: @exams, meta: meta_attributes(@exams), adapter: :json
    else
      @exams = Exam.includes(:unit).order(name: :asc)

      render json: @exams
    end
  end
end
