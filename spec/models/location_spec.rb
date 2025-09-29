require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'associations' do
    it { should have_many(:events) }
  end

  describe 'validations' do
    subject { build(:location) }

    it { should validate_presence_of(:name) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:location)).to be_valid
    end

    it 'creates a location with events' do
      location = create(:location, :with_events)
      expect(location.events.count).to eq(2)
    end
  end

  describe 'attributes' do
    let(:location) { build(:location) }

    it 'has a name' do
      expect(location.name).to be_present
    end

    it 'has an address' do
      expect(location.address).to be_present
    end

    it 'has a city' do
      expect(location.city).to be_present
    end

    it 'has a state' do
      expect(location.state).to be_present
    end

    it 'has a country' do
      expect(location.country).to be_present
    end

    it 'has a zipcode' do
      expect(location.zipcode).to be_present
    end

    it 'has a phone' do
      expect(location.phone).to be_present
    end

    it 'has an email' do
      expect(location.email).to be_present
    end
  end
end
