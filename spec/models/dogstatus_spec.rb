require 'rails_helper'
describe DogStatus do

  it 'has a valid factory' do
    expect(build(:dog_status)).to be_valid
  end
  it { should belong_to(:location) }  
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:guidelines) }
  it { should define_enum_for(:status).
    with([:off_lead, :on_lead, :no_dogs]) }
end
