class Reference < ApplicationRecord
  include Sortable

  has_many :exam_reference, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.sort_by
    %w[name]
  end

  private_class_method :sort_by
end
