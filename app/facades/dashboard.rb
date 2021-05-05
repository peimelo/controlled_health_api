class Dashboard
  alias read_attribute_for_serialization send

  def initialize(current_user, heights_for_range)
    @current_user = current_user
    @heights_for_range = heights_for_range
  end

  def heights
    @heights ||= ActiveModel::Serializer::CollectionSerializer.new(@current_user.heights_sorted('date', 'desc'),
                                                                   serializer: HeightSerializer).as_json
  end

  def weights
    @weights ||= ActiveModel::Serializer::CollectionSerializer.new(@current_user.weights_sorted('date', 'desc'),
                                                                   serializer: WeightSerializer,
                                                                   heights_for_range: @heights_for_range).as_json
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end
