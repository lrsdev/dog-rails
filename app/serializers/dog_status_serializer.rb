class DogStatusSerializer < ActiveModel::Serializer
  attributes :status, :guidelines, :created_at
  belongs_to :location
end
