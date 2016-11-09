FactoryGirl.define do
  factory :project do
    account_ids { [create(:account).id] }
    sequence(:name) { Faker::Commerce.department }
  end
end
