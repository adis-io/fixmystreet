FactoryGirl.define do
  factory :user do
    email { Faker::Internet.free_email }
    role 'regular'
  end
end
