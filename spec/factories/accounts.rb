FactoryGirl.define do
  factory :account do
    service_id { create(:service).id }
    sequence(:name) { Faker::Company.name }
    url { Faker::Internet.url }
    login { Faker::Internet.user_name }
    password { Faker::Internet.password(8) }
    note { Faker::Lorem.sentence }
  end
end
