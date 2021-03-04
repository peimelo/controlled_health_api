class Height < ApplicationRecord
  include Sortable

  belongs_to :user

  validates :date, presence: true
  validates :value, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 20,
                      less_than_or_equal_to: 250
                    }

  def self.value_by_date(date, user_id)
    heights = Height.where(user_id: user_id)
                    .sorted('date', 'desc')
                    .pluck(:date, :value)

    return 0 if heights.count.zero?

    heights.each do |height|
      return height[1] if date >= height[0]
    end

    heights.last[1]
  end

  def self.sort_by
    %w[date value]
  end

  private_class_method :sort_by
end
