FactoryBot.define do
  factory :event_artist do
    association :event
    association :artist
  end
end
