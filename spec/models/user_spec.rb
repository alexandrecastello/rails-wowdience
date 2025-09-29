require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:reviews) }
    it { should have_many(:events).through(:reviews) }
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'devise modules' do
    it 'includes database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(User.devise_modules).to include(:validatable)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'creates a user with reviews' do
      user = create(:user, :with_reviews)
      expect(user.reviews.count).to eq(3)
    end
  end
end
