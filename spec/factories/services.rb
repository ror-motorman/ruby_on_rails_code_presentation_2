FactoryGirl.define do
  factory :service do
    sequence(:name) { Faker::Internet.domain_word }
    sequence(:url) { Faker::Internet.url }
    login_button_identifier 'button'
    login_field_identifier 'login'
  end
end
