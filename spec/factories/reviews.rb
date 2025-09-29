FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(from: 0.5, to: 5.0).round(1) }
    comment { Faker::Lorem.paragraph }
    association :user
    association :event

    trait :high_rating do
      rating { Faker::Number.between(from: 4.0, to: 5.0).round(1) }
    end

    trait :low_rating do
      rating { Faker::Number.between(from: 0.5, to: 2.0).round(1) }
    end

    trait :without_comment do
      comment { nil }
    end
  end
end
