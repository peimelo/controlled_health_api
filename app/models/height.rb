class Height < ApplicationRecord
  belongs_to :user

  validates :date, :value, presence: true

  scope :ordered, lambda {
                    select(:id, :date, :value)
                      .order(date: :desc)
                  }

  def self.value_by_date(date)
    return Height.first.value if Height.count == 1

    Height.ordered.each do |height|
      return height.value if date >= height.date
    end

    Height.ordered.last.value
  end
end
