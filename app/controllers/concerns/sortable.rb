module Sortable
  protected

  def sort
    sort = params[:sort] == '' ? 'date' : params[:sort]
    desc = params[:dir] == '' ? 'desc' : params[:dir]

    "#{sort} #{desc}"
  end
end
