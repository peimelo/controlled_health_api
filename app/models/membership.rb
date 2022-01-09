class Membership < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates :user_id, presence: true,
                      uniqueness: { scope: :account_id }
end
