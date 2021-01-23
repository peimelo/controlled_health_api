class Weight < ApplicationRecord
  belongs_to :user

  validates :date, :value, presence: true

  scope :sorted_by_date, -> { order(date: :desc) }

  def maximum(height)
    ideal_value(24.99, height)
  end

  def minimum(height)
    ideal_value(18.49, height)
  end

  private

  def ideal_value(value, height)
    (value * height * height).round(2)
  end
end
