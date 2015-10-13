class ReportSerializer < ActiveModel::Serializer
  attributes :id, :location_id, :blurb, :animal_id, :created_at, :latitude, :longitude,
    :image_thumbnail, :image_medium
  belongs_to :location
  belongs_to :animal

  def image_thumbnail
    object.image.url(:thumb)
  end

  def image_medium
    object.image.url(:medium)
  end

  def latitude
    object.geolocation.y
  end

  def longitude
    object.geolocation.x
  end
end
