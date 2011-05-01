require 'spec_helper'

describe City do
  it { should validate_presence_of :name, :lat, :long, :zoom, :country_id }
  it { should allow_mass_assignment_of :name, :lat, :long, :zoom, :country_id }
  City.create! :name => 'aoeuaoeu',
               :lat => 1, :long => 3, :zoom => 1,
               :country_id => 1

  it { should validate_uniqueness_of :name }

  it { should have_many :reports }
  it { should belong_to :country }
end
