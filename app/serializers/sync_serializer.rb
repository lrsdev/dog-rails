class SyncSerializer < ActiveModel::Serializer
  attribute :locations
  attribute :deleted_location_ids
  attribute :animals
  attribute :deleted_animal_ids
  attribute :synced_at
  attribute :sync_elapsed

  def locations
    s = ActiveModel::Serializer::ArraySerializer.new(object.locations, serializer: LocationSerializer)
    ActiveModel::Serializer::Adapter::FlattenJson.new(s).as_json
  end

  def animals
    s = ActiveModel::Serializer::ArraySerializer.new(object.animals, serializer: AnimalSerializer)
    ActiveModel::Serializer::Adapter::FlattenJson.new(s).as_json
  end
end
