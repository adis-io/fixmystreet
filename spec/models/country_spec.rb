require 'spec_helper'

describe Country do
  it { should validate_presence_of :name }
  it { should validate_presence_of :lat }
  it { should validate_presence_of :lng }
  it { should validate_presence_of :zoom }
  it { should validate_presence_of :country_code }

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :lat }
  it { should allow_mass_assignment_of :lng }
  it { should allow_mass_assignment_of :zoom }
  it { should allow_mass_assignment_of :country_code }

  it { should have_many :cities }

  context "uniqueness" do
    before do
      Country.create! :name => "Kyrgyzstan", :lat => 1, :lng => 1, :zoom => 1, :country_code => 'kg'
    end
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :country_code }
  end
end
