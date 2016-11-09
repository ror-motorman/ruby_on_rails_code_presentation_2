FactoryGirl.define do
  factory :admin, class: User do
    full_name { Faker::Name.name }
    sequence(:login) { Faker::Internet.user_name }
    sequence(:email) { Faker::Internet.email }
    origin_password { Faker::Internet.password(8) }
    position 'admin'
    role 'admin'
  end

  factory :user do
    full_name { Faker::Name.name }
    sequence(:login) { Faker::Internet.user_name }
    sequence(:email) { Faker::Internet.email }
    origin_password { Faker::Internet.password(8) }
    position 'user'
    role 'user'
  end
end
