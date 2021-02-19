module Sortable
  ATTRIBUTTES = %w[date value]
  DIRECTIONS = %w[asc desc]

  protected

  def sort
    sort = ATTRIBUTTES.include?(params[:sort]) ? params[:sort] : 'date'
    desc = DIRECTIONS.include?(params[:dir]) ? params[:dir] : 'desc'

    "#{sort} #{desc}"
  end
end
