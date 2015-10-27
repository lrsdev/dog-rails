# spec/factories/locations.rb
include ActionDispatch::TestProcess

# Create a location object with a an image attachment and a dog_status
#
#
FactoryGirl.define do
  factory :location do
    #association :dog_statuses, factory: :dog_status
    geolocation 'POINT(123.333 56.53)'
    animal_blurb 'Some blurb'
    region 0
    category 0
    name 'Some name'
    image { fixture_file_upload "#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg' }
    after(:build) do |location|
      location.dog_statuses << build(:dog_status, :location => location)
    end
  end

  factory :dog_status do
    location
    status 0
    guidelines 'Some dog guidelines'
  end
end
