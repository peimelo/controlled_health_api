module Sortable
  extend ActiveSupport::Concern

  DIRECTIONS = %w[asc desc].freeze

  class_methods do
    def sorted(column, direction)
      if respond_to?(:sort_by, true)
        column = sort_by.include?(column) ? column : sort_by[0]
      else
        column_names.include?(column) ? column : column_names[1]
      end
      direction = DIRECTIONS.include?(direction) ? direction : 'desc'

      sort_string = [column, direction].join(' ')
      order(sort_string)
    end
  end
end
