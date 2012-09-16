
FactoryGirl.define do
  factory :our_site do
    association :category
    name { Faker::Lorem.word }
  end
end
