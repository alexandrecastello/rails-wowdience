FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }

    trait :with_events do
      after(:create) do |artist|
        create_list(:event_artist, 2, artist: artist)
      end
    end
  end
end
