class Height < ApplicationRecord
  belongs_to :user

  validates :date, :value, presence: true
end
