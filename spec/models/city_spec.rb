require 'spec_helper'

describe City do
  it { should validate_presence_of :name }
  it { should validate_presence_of :lat }
  it { should validate_presence_of :lng }
  it { should validate_presence_of :zoom }
  it { should validate_presence_of :country_id }
  it { should validate_presence_of :slug }

  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :lat }
  it { should allow_mass_assignment_of :lng }
  it { should allow_mass_assignment_of :zoom }
  it { should allow_mass_assignment_of :country_id }
  it { should allow_mass_assignment_of :slug }

  it { should have_many :reports }
  it { should belong_to :country }

  context "uniqueness" do
    before do
      Factory(:city)
    end
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :slug }
  end

  describe "#to_param" do
    subject { @city.to_param }
    before do
      @city = Factory(:city)
    end
    it { should eq @city.slug }
  end
end
