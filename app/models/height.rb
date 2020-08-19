class Height < ApplicationRecord
  belongs_to :user

  validates :date, :value, presence: true

  scope :ordered, lambda {
                    select(:id, :date, :value)
                      .order(date: :desc)
                  }
end
