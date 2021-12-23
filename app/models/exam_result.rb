class ExamResult < ApplicationRecord
  include Sortable

  self.table_name = 'exams_results'

  belongs_to :exam
  belongs_to :result

  validates :exam_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 99_999_999.99 }
  validates :exam_id, uniqueness: { scope: :result_id }

  scope :graphic_values, lambda { |user, exam_id|
    select('results.id as result_id, results.date, results.description, exams_results.id, exams_results.value')
      .joins(:result)
      .where('results.user_id = ? AND exams_results.exam_id = ?', user.id, exam_id)
      .order('results.date')
  }

  scope :ordered, lambda {
    select(:id, :value)
      .includes(exam: :unit)
      .order(id: :desc)
  }

  def self.sort_by
    %w[exams.name value]
  end

  private_class_method :sort_by
end
