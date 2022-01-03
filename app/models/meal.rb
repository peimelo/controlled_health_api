class Meal < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }

  scope :ordered, lambda {
    select(:id, :name)
  }
end
