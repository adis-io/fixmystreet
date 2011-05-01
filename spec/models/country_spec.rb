require 'spec_helper'

describe Country do
  it { should validate_presence_of :name, :lat, :long, :zoom }
  it { should allow_mass_assignment_of :name, :lat, :long, :zoom,
    :default_city }
  Country.create! :name => 'aoeuaoeu',
               :lat => 1, :long => 3, :zoom => 1

  it { should validate_uniqueness_of :name }
  it { should have_many :cities }
  it { should have_one :default_city, :class_name => "City" }
end
