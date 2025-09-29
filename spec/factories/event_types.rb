FactoryBot.define do
  factory :event_type do
    name { Faker::Music.genre }

    trait :concert do
      name { "Concert" }
    end

    trait :festival do
      name { "Festival" }
    end

    trait :with_events do
      after(:create) do |event_type|
        create_list(:event, 3, event_type: event_type)
      end
    end
  end
end
