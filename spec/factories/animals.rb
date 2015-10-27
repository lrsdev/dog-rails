include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :animal do
    name 'Seal'
    blurb 'Some sort of blurb'
    guidelines 'Some guidelines pertaining to dogs'
    ext_url 'http://stuff.com'
    active true
    image { fixture_file_upload "#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg' }
  end
end
