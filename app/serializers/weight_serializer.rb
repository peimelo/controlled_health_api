class WeightSerializer < ActiveModel::Serializer
  attributes :id, :date, :value, :range

  def range
    heights = @instance_options[:heights_for_range] || []
    height_value = Height.value_by_date(object.date, heights)

    {
      min: object.minimum(height_value).to_f,
      max: object.maximum(height_value).to_f
    }
  end
end
