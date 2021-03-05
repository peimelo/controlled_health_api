class ExamReference < ApplicationRecord
  self.table_name = 'exams_references'

  belongs_to :exam
  belongs_to :reference, optional: true

  validates :minimum_age, numericality: { less_than_or_equal_to: :maximum_age },
                          unless: proc { |a| a.minimum_age.blank? or a.maximum_age.blank? }

  validates :maximum_age, numericality: { greater_than_or_equal_to: :minimum_age },
                          unless: proc { |a| a.minimum_age.blank? or a.maximum_age.blank? }

  validates :minimum_value, numericality: { less_than_or_equal_to: :maximum_value },
                            unless: proc { |a| a.minimum_value.blank? or a.maximum_value.blank? }

  validates :maximum_value, numericality: { greater_than_or_equal_to: :minimum_value },
                            unless: proc { |a| a.minimum_value.blank? or a.maximum_value.blank? }

  validates :minimum_age, numericality: { less_than_or_equal_to: 199.999 },
                          unless: proc { |a| a.minimum_age.blank? }
  validates :maximum_age, numericality: { less_than_or_equal_to: 199.999 },
                          unless: proc { |a| a.maximum_age.blank? }

  validates :minimum_value, numericality: { less_than_or_equal_to: 99_999_999.99 },
                            unless: proc { |a| a.minimum_value.blank? }
  validates :maximum_value, numericality: { less_than_or_equal_to: 99_999_999.99 },
                            unless: proc { |a| a.maximum_value.blank? }
end
