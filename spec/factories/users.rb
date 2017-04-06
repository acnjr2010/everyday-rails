FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today

    after(:create) { |user| user.add_role :admin }

    factory :user_editor do
      email { Faker::Internet.email }
      password "password"
      password_confirmation "password"
      confirmed_at Date.today

      after(:create) { |user| user.add_role :editor }
    end

    factory :user_author do
      email { Faker::Internet.email }
      password "password"
      password_confirmation "password"
      confirmed_at Date.today

      after(:create) { |user| user.add_role :author }
    end

    factory :user_member do
      email { Faker::Internet.email }
      password "password"
      password_confirmation "password"
      confirmed_at Date.today

      after(:create) { |user| user.add_role :member }
    end

    factory :user_guest do
      email { Faker::Internet.email }
      password "password"
      password_confirmation "password"
      confirmed_at Date.today

      after(:create) { |user| user.add_role :guest }
    end
  end
end
