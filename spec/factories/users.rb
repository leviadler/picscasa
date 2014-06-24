FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
    password "foobar"
    password_confirmation "foobar"
  end
end