include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :report do
    location
    animal
    geolocation 'POINT(123.333 56.53)'
    blurb 'Some blurb describing the animal'
    image { fixture_file_upload "#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg' }
  end
end
