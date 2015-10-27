require 'rails_helper'
describe Animal do
  it 'has a valid factory' do
    expect(build(:animal)).to be_valid
  end
  it { should have_many(:reports) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).
       is_at_most(50) }
  it { should validate_presence_of(:blurb) }
  it { should validate_presence_of(:guidelines) }
  it { should validate_inclusion_of(:active).in_array([true, false]) }
  it { should validate_presence_of(:ext_url) }
  it { should validate_presence_of(:image) }
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
       allowing('image/png', 'image/jpg', 'image/jpeg').
       rejecting('text/plain', 'text/xml') }
end
