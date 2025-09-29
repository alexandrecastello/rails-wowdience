require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:event_type) }
    it { should belong_to(:location) }
    it { should have_many(:event_artists) }
    it { should have_many(:artists).through(:event_artists) }
    it { should have_many(:reviews) }
    it { should have_many(:users).through(:reviews) }
  end

  describe 'validations' do
    subject { build(:event) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_date) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:event)).to be_valid
    end

    it 'creates an event with artists' do
      event = create(:event, :with_artists)
      expect(event.artists.count).to eq(2)
    end

    it 'creates an event with reviews' do
      event = create(:event, :with_reviews)
      expect(event.reviews.count).to eq(3)
    end

    it 'creates a past event' do
      past_event = create(:event, :past_event)
      expect(past_event.start_date).to be < Time.current
    end

    it 'creates a future event' do
      future_event = create(:event, :future_event)
      expect(future_event.start_date).to be > Time.current
    end
  end

  describe '#average_rating' do
    let(:event) { create(:event) }

    context 'when there are no reviews' do
      it 'returns 0' do
        expect(event.average_rating).to eq(0)
      end
    end

    context 'when there are reviews' do
      before do
        create(:review, event: event, rating: 4.0)
        create(:review, event: event, rating: 5.0)
        create(:review, event: event, rating: 3.0)
      end

      it 'returns the average rating rounded to 1 decimal place' do
        expect(event.average_rating).to eq(4.0)
      end
    end
  end

  describe '#total_reviews' do
    let(:event) { create(:event) }

    context 'when there are no reviews' do
      it 'returns 0' do
        expect(event.total_reviews).to eq(0)
      end
    end

    context 'when there are reviews' do
      before do
        create_list(:review, 3, event: event)
      end

      it 'returns the count of reviews' do
        expect(event.total_reviews).to eq(3)
      end
    end
  end

  describe 'scopes' do
    let!(:event1) { create(:event, name: 'Event A', start_date: 1.day.from_now) }
    let!(:event2) { create(:event, name: 'Event B', start_date: 2.days.from_now) }

    it 'orders by start_date' do
      expect(Event.order(:start_date)).to eq([event1, event2])
    end
  end
end
