require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'associations' do
    it { should have_many(:event_artists) }
    it { should have_many(:events).through(:event_artists) }
  end

  describe 'validations' do
    subject { build(:artist) }

    it { should validate_presence_of(:name) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:artist)).to be_valid
    end

    it 'creates an artist with events' do
      artist = create(:artist, :with_events)
      expect(artist.events.count).to eq(2)
    end
  end

  describe 'scopes' do
    let!(:artist1) { create(:artist, name: 'Artist A') }
    let!(:artist2) { create(:artist, name: 'Artist B') }

    it 'orders by name' do
      expect(Artist.order(:name)).to eq([artist1, artist2])
    end
  end
end
