class Food < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: {
              case_sensitive: false, scope: [:measure]
            }

  scope :ordered, lambda {
    select(:id, :name, :measure, :amount, :cho, :kcal)
      .order(:name)
  }
end
