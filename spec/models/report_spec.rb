require 'spec_helper'

describe Report do
  it { should validate_presence_of :title,
    :description, :latitude, :longtitude, :user, :city
  }

  it { should allow_mass_assignment_of :title,
    :description, :latitude, :longtitude, :user, :video_url,
    :photo1, :photo2, :photo3, :photo4, :photo5, :city_id
  }

  it { should validate_length_of :title, :minimum => 5,
    :maximum => 250
  }

  it { should validate_length_of :description, :minimum => 20,
    :maximum => 5000
  }
  country = Country.create! :name => 'KG', :lat => 1,
    :long => 1, :zoom => 1

  city = City.create! :name => 'Karabalta', :lat => 1, :long => 1,
    :zoom => 1, :country_id => country, :subdomain => 'karabalta'

  Report.create!(:title => 'asdfasdf',
                :description => 'adfasdfas asdf asdf asd fasdf asdf',
                :latitude => 1, :longtitude => 1,
                :user => User.create!,
                :city_id => city)

  it { should validate_uniqueness_of :title }

  it { should belong_to :user }
  it { should belong_to :city }
end
