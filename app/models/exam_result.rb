class ExamResult < ApplicationRecord
  include Sortable

  self.table_name = 'exams_results'

  belongs_to :exam
  belongs_to :result

  validates :exam_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 99_999_999.99 }
  validates :exam_id, uniqueness: { scope: :result_id }

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
