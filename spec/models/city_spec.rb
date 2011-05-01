require 'spec_helper'

describe City do
  it { should validate_presence_of :name, :lat, :long, :zoom,
    :country_id, :subdomain }
  it { should allow_mass_assignment_of :name, :lat, :long, :zoom,
    :country_id, :subdomain }
  City.create! :name => 'aoeuaoeu',
               :lat => 1, :long => 3, :zoom => 1,
               :country_id => 1,
               :subdomain => "bishkek"

  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :subdomain,
    :case_sensitive => false }
  it { should validate_exclusion_of :subdomain,
    :in => %w(support blog www help api)
  }

  it { should have_many :reports }
  it { should belong_to :country }
end
