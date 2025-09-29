FactoryBot.define do
  factory :event do
    name { Faker::Music.album }
    start_date { Faker::Time.between(from: DateTime.now, to: 1.year.from_now) }
    end_date { start_date + 3.hours }
    description { Faker::Lorem.paragraph }
    association :event_type
    association :location

    trait :with_artists do
      after(:create) do |event|
        create_list(:event_artist, 2, event: event)
      end
    end

    trait :with_reviews do
      after(:create) do |event|
        create_list(:review, 3, event: event)
      end
    end

    trait :past_event do
      start_date { Faker::Time.between(from: 1.year.ago, to: 1.month.ago) }
      end_date { start_date + 3.hours }
    end

    trait :future_event do
      start_date { Faker::Time.between(from: 1.month.from_now, to: 1.year.from_now) }
      end_date { start_date + 3.hours }
    end
  end
end
