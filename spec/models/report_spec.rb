require 'spec_helper'

describe Report do
  it { should validate_presence_of :title,
    :description, :latitude, :longtitude, :user
  }

  it { should allow_mass_assignment_of :title,
    :description, :latitude, :longtitude, :user, :video_url,
    :photo1, :photo2, :photo3, :photo4, :photo5
  }

  it { should validate_length_of :title, :minimum => 5,
    :maximum => 250
  }

  it { should validate_length_of :description, :minimum => 20,
    :maximum => 5000
  }
  Report.create!(:title => 'asdfasdf',
                :description => 'adfasdfas asdf asdf asd fasdf asdf',
                :latitude => 1, :longtitude => 1,
                :user => User.create!)
  it { should validate_uniqueness_of :title }

  it { should belong_to :user }
end
