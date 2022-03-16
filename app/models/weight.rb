class Weight < ApplicationRecord
  include Sortable

  belongs_to :account

  validates :date, presence: true
  validates :value, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 1,
                      less_than_or_equal_to: 400
                    }

  def maximum(height_value)
    ideal_value(24.99, height_value)
  end

  def minimum(height_value)
    ideal_value(18.49, height_value)
  end

  def self.sort_by
    %w[date value]
  end

  private_class_method :sort_by

  private

  def ideal_value(value, height_value)
    (value * height_value / 100 * height_value / 100).round(2)
  end
end
