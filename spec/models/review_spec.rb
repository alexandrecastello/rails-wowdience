require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe 'validations' do
    subject { build(:review) }

    it { should validate_presence_of(:rating) }
    it { should validate_inclusion_of(:rating).in_range(0.5..5.0).with_message('A nota deve estar entre 0.5 e 5.0') }
    it { should validate_uniqueness_of(:user_id).scoped_to(:event_id).with_message('Você já avaliou este evento') }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:review)).to be_valid
    end

    it 'creates a review with high rating' do
      review = create(:review, :high_rating)
      expect(review.rating).to be >= 4.0
    end

    it 'creates a review with low rating' do
      review = create(:review, :low_rating)
      expect(review.rating).to be <= 2.0
    end

    it 'creates a review without comment' do
      review = create(:review, :without_comment)
      expect(review.comment).to be_nil
    end
  end

  describe 'uniqueness validation' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }

    before do
      create(:review, user: user, event: event)
    end

    it 'prevents duplicate reviews from the same user for the same event' do
      duplicate_review = build(:review, user: user, event: event)
      expect(duplicate_review).not_to be_valid
      expect(duplicate_review.errors[:user_id]).to include('Você já avaliou este evento')
    end

    it 'allows the same user to review different events' do
      another_event = create(:event)
      review = build(:review, user: user, event: another_event)
      expect(review).to be_valid
    end

    it 'allows different users to review the same event' do
      another_user = create(:user)
      review = build(:review, user: another_user, event: event)
      expect(review).to be_valid
    end
  end

  describe 'rating validation' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }

    it 'accepts valid ratings' do
      valid_ratings = [0.5, 1.0, 2.5, 3.0, 4.5, 5.0]
      valid_ratings.each do |rating|
        review = build(:review, user: user, event: event, rating: rating)
        expect(review).to be_valid, "Rating #{rating} should be valid"
      end
    end

    it 'rejects invalid ratings' do
      invalid_ratings = [0.0, 0.4, 5.1, 6.0, -1.0]
      invalid_ratings.each do |rating|
        review = build(:review, user: user, event: event, rating: rating)
        expect(review).not_to be_valid, "Rating #{rating} should be invalid"
        expect(review.errors[:rating]).to include('A nota deve estar entre 0.5 e 5.0')
      end
    end
  end
end
