require 'rails_helper'

describe Location do

  it 'has a valid factory' do
    expect(build(:location)).to be_valid
  end
  it { should have_many(:reports) }
  it { should have_many(:dog_statuses) }
  it { should accept_nested_attributes_for(:dog_statuses) }
  it { should validate_presence_of(:dog_statuses) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:animal_blurb) }
  it { should validate_presence_of(:geolocation) }
  it { should validate_presence_of(:image) }
  it { should define_enum_for(:region).
    with(["Southland", "Otago", "Canterbury", "Westland", "Marlborough",
      "Nelson", "Wellington", "Hawke's Bay", "New Plymouth", "Auckland"])}
  it { should define_enum_for(:category).
    with([:beach, :track, :park])}
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
       allowing('image/png', 'image/jpg', 'image/jpeg').
       rejecting('text/plain', 'text/xml') }
  it { should validate_inclusion_of(:active).in_array([true, false]) }
end
