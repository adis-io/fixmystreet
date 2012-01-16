FactoryGirl.define do
  factory :country do
    name 'Kyrgyzstan'
    lat {Faker::Geolocation.lat }
    lng {Faker::Geolocation.lng }
    zoom 12
    country_code 'kg'
  end
end
