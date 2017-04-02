FactoryGirl.define do
  factory :student do
    association :academy
    name { Faker::Name.name }
    document { Faker::Number.number(11)}
    email { Faker::Internet.safe_email }

    factory :invalid_studen do
      name nil
    end
  end
end
