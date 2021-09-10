class Api::V1::ExamsController < ApplicationController
  before_action :authenticate_api_user!

  def index
    @exams = Exam.includes(:unit).order(name: :asc)

    render json: @exams
  end
end
