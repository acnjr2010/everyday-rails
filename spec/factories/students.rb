FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    document { Faker::Number.number(11)}
    email { Faker::Internet.safe_email }
    association :academy

    factory :invalid_student do
      name nil
    end
  end
end
