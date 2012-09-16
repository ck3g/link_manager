
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "secret"
    password_confirmation "secret"
    role 1 # admin

    factory :moderator do
      role 2
    end
  end
end
