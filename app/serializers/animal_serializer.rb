class AnimalSerializer < ActiveModel::Serializer
  attributes :id, :name, :blurb, :guidelines, :ext_url, :image_thumbnail, :image_medium

  def image_thumbnail
    object.image.url(:thumb)
  end

  def image_medium
    object.image.url(:medium)
  end

end
