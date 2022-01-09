class Account < ApplicationRecord
  include Sortable

  belongs_to :owner, class_name: 'User'

  has_many :alimentations, dependent: :destroy
  has_many :heights, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :weights, dependent: :destroy

  has_many :invitations, dependent: :delete_all
  has_many :memberships, dependent: :delete_all
  has_many :users, through: :memberships

  delegate :sorted, to: :heights, prefix: true
  delegate :sorted, to: :results, prefix: true
  delegate :sorted, to: :weights, prefix: true

  validates :name, presence: true,
                   length: { minimum: 3 },
                   uniqueness: { case_sensitive: false, scope: :owner_id }

  def self.sort_by
    %w[name]
  end

  private_class_method :sort_by
end
