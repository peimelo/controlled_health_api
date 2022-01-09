module AllHeights
  private

  def heights_for_range
    @current_account.heights_sorted('date', 'desc')
                    .pluck(:date, :value)
  end
end
