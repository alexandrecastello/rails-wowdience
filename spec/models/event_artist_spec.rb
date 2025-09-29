require 'rails_helper'

RSpec.describe EventArtist, type: :model do
  describe 'associations' do
    it { should belong_to(:event) }
    it { should belong_to(:artist) }
  end

  describe 'validations' do
    subject { build(:event_artist) }

    it { should belong_to(:event) }
    it { should belong_to(:artist) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:event_artist)).to be_valid
    end

    it 'creates an event_artist with event and artist' do
      event_artist = create(:event_artist)
      expect(event_artist.event).to be_present
      expect(event_artist.artist).to be_present
    end
  end

  describe 'uniqueness' do
    let(:event) { create(:event) }
    let(:artist) { create(:artist) }

    it 'allows multiple artists for the same event' do
      create(:event_artist, event: event, artist: artist)
      another_artist = create(:artist)
      expect { create(:event_artist, event: event, artist: another_artist) }.not_to raise_error
    end

    it 'allows the same artist for multiple events' do
      create(:event_artist, event: event, artist: artist)
      another_event = create(:event)
      expect { create(:event_artist, event: another_event, artist: artist) }.not_to raise_error
    end
  end
end
