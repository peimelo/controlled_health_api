module Sortable
  extend ActiveSupport::Concern

  DIRECTIONS = %w[asc desc].freeze

  class_methods do
    def sorted(column, direction)
      column = column_names.include?(column) ? column : column_names[1]
      direction = DIRECTIONS.include?(direction) ? direction : 'desc'

      order("#{column} #{direction}")
    end
  end
end
