class Result < ApplicationRecord
  include Sortable

  belongs_to :account

  has_many :exam_result, lambda {
    includes(exam: :unit)
      .joins(:exam)
  }, dependent: :delete_all
  has_many :exam, through: :exam_result

  validates :date, :description, presence: true
  validates :date, uniqueness: { scope: :description, case_sensitive: false }
  validates :description, uniqueness: { scope: :date }

  validate :uniqueness_of_exam_result

  delegate :sorted, to: :exam_result, prefix: true

  def self.sort_by
    %w[date description]
  end

  private_class_method :sort_by

  private

  def uniqueness_of_exam_result
    hash = {}
    exam_result.each do |exam_result|
      if hash[exam_result.exam_id]
        # This line is needed to form the parent to error out, otherwise the save would still happen
        errors.add(:'exam_result.exame_id', 'duplicate error') if errors[:'exam_result.exam_id'].blank?
        # This line adds the error to the child to view in your fields_for
        exam_result.errors.add(:exam_id, :taken2)
      end
      hash[exam_result.exam_id] = true
    end
  end
end
