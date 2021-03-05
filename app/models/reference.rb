class Reference < ApplicationRecord
  # include Scopes

  has_many :exam_reference, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
