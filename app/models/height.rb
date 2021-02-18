class Height < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :value, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 250 }

  scope :filter_by_user_id, ->(user_id) { where(user_id: user_id) }
  scope :sorted, ->(sort) { order(sort) }

  def self.value_by_date(date, user_id)
    heights = Height.filter_by_user_id(user_id).sorted('date desc').pluck(:id, :date, :value)

    return 0 if heights.count.zero?

    heights.each do |height|
      return height[2] if date >= height[1]
    end

    heights.last[2]
  end
end
