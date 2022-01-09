class Invitation < ApplicationRecord
  include Sortable

  belongs_to :account

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false, scope: :account_id },
                    email: true
  validates :name, presence: true

  scope :by_account, ->(account_id) { where(account_id: account_id) }
  scope :by_email, ->(email) { where(email: email) }
  scope :by_owner, ->(user) { joins(:account).where('accounts.owner_id = ?', user.id) }

  def self.sort_by
    %w[name email created_at accepted_at]
  end

  private_class_method :sort_by
end
