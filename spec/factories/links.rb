
FactoryGirl.define do
  factory :link do
    association :user
    association :placement
    association :our_site
    association :status
    url "url"
    keyword "keyword"
    page_rank 9
  end
end
