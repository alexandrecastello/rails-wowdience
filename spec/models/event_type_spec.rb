require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe 'associations' do
    it { should have_many(:events) }
  end

  describe 'validations' do
    subject { build(:event_type) }

    it { should validate_presence_of(:name) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:event_type)).to be_valid
    end

    it 'creates an event type with events' do
      event_type = create(:event_type, :with_events)
      expect(event_type.events.count).to eq(3)
    end

    it 'creates a concert event type' do
      concert = create(:event_type, :concert)
      expect(concert.name).to eq('Concert')
    end

    it 'creates a festival event type' do
      festival = create(:event_type, :festival)
      expect(festival.name).to eq('Festival')
    end
  end

  describe 'scopes' do
    let!(:concert) { create(:event_type, :concert) }
    let!(:festival) { create(:event_type, :festival) }

    it 'can find by name' do
      expect(EventType.find_by(name: 'Concert')).to eq(concert)
    end
  end
end
