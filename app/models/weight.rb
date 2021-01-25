class Weight < ApplicationRecord
  belongs_to :user

  validates :date, :value, presence: true

  scope :sorted_by_date, -> { order(date: :desc) }

  def maximum(height_value)
    ideal_value(24.99, height_value)
  end

  def minimum(height_value)
    ideal_value(18.49, height_value)
  end

  private

  def ideal_value(value, height_value)
    (value * height_value * height_value).round(2)
  end
end
