class Height < ApplicationRecord
  belongs_to :user

  validates :date, :value, presence: true

  scope :filter_by_user_id, ->(user_id) { where(user_id: user_id) }
  scope :sorted_by_date, -> { order(date: :desc) }

  def self.value_by_date(date, user_id)
    return 0 if Height.filter_by_user_id(user_id).count.zero?

    Height.filter_by_user_id(user_id).sorted_by_date.each do |height|
      return height.value if date >= height.date
    end

    Height.filter_by_user_id(user_id).sorted_by_date.last.value
  end
end
