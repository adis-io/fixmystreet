FactoryGirl.define do
  factory :user do
    email { Faker::Internet.free_email }
    role 'regular'
    name { Faker::Name.name }
  end
end
