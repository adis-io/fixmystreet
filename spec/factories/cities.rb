FactoryGirl.define do
  factory :city do
    name { Faker::Address.city }
    lat {Faker::Geolocation.lat }
    lng {Faker::Geolocation.lng }
    zoom 12
    slug { name.gsub(/\s+/, '').downcase }

    country
  end
end
