class AlimentationFood < ApplicationRecord
  self.table_name = 'alimentations_foods'

  belongs_to :alimentation
  belongs_to :food

  validates :alimentation_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 1000.00 }
  validates :alimentation_id, uniqueness: { scope: :food_id }
  validates :food_id, uniqueness: { scope: :alimentation_id }

  scope :ordered, lambda {
    select(:id, :value)
      .includes(:food)
      .order(id: :desc)
  }
end
