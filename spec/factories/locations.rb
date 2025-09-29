FactoryBot.define do
  factory :location do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    zipcode { Faker::Address.zip_code.to_i }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }

    trait :with_events do
      after(:create) do |location|
        create_list(:event, 2, location: location)
      end
    end
  end
end
