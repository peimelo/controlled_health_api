class Weight < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :value, presence: true,
                    numericality: { greater_than_or_equal_to: 3, less_than_or_equal_to: 400 }

  scope :sorted, ->(sort) { order(sort) }

  def maximum(height_value)
    ideal_value(24.99, height_value)
  end

  def minimum(height_value)
    ideal_value(18.49, height_value)
  end

  private

  def ideal_value(value, height_value)
    (value * height_value / 100 * height_value / 100).round(2)
  end
end
