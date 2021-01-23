class WeightSerializer < ActiveModel::Serializer
  attributes :id, :date, :value, :min, :max

  def min
    height = Height.value_by_date(object.date)
    object.minimum(height).to_f
  end

  def max
    height = Height.value_by_date(object.date)
    object.maximum(height).to_f
  end
end
