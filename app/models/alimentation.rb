class Alimentation < ApplicationRecord
  belongs_to :account
  belongs_to :meal

  has_many :alimentation_food, lambda {
    includes(:food)
      .joins(:food)
      .order('foods.name')
  }, dependent: :delete_all

  scope :ordered, lambda {
    select(:id, :date, :meal_id)
      .includes(:meal)
      .order(date: :desc)
  }
end
