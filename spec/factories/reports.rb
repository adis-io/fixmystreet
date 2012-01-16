FactoryGirl.define do
  factory :report do
    title { Faker::Lorem.sentence(5) }
    description { Faker::Lorem.sentence(20) }
    lat {Faker::Geolocation.lat }
    lng {Faker::Geolocation.lng }

    city
    user
  end
end
