class WeightSerializer < ActiveModel::Serializer
  attributes :id, :date, :value, :range

  def range
    height_value = Height.value_by_date(object.date, @instance_options[:heights_for_range])

    range = {}
    range[:min] = object.minimum(height_value).to_f
    range[:max] = object.maximum(height_value).to_f
    range
  end
end
