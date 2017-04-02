FactoryGirl.define do
  factory :academy do
    academy_name { Faker::Name.title }
    director_name { Faker::Name.name }
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.subscriber_number(8) }
    email { Faker::Internet.safe_email }

    factory :invalid_academy do
      academy_name nil
    end
  end
end
