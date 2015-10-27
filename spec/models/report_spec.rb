require 'rails_helper'
describe Report do
  it 'has a valid factory' do
    expect(build(:report)).to be_valid
  end
  it { should belong_to(:location) }
  it { should belong_to(:animal) }
  it { should validate_presence_of(:geolocation) }
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
       allowing('image/png', 'image/jpg', 'image/jpeg').
       rejecting('text/plain', 'text/xml') }
end
