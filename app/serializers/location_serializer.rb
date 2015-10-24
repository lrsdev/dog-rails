class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :animal_blurb, :dog_status, :dog_guidelines,
    :image_thumbnail, :image_medium, :latitude, :longitude
  #has_many :reports 
  #has_many :dog_statuses, :key => :dog_status

  def image_medium
    object.image.url(:medium)
  end

  def image_thumbnail
    object.image.url(:thumbnail)
  end

  def latitude
    object.geolocation.y
  end

  def longitude
    object.geolocation.x
  end

  def dog_status
    object.dog_statuses.last.status
  end

  def dog_guidelines
    object.dog_statuses.last.guidelines
  end

  # Only the current dog status needs to be returned for location.
  # root argument removes extra dog_status key in response.
  #def dog_statuses
  #  object.dog_statuses.last
  #end
end

