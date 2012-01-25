require 'spec_helper'

describe Report do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :lat }
  it { should validate_presence_of :lng }
  it { should validate_presence_of :user }

  context "uniqueness" do
    before do
      User.create!
      City.create!(:name => "Bishkek", :lat => 1, :lng => 1, :slug => 'bishkek', :zoom => 1, :country_id => 1)
      Report.create!(title:  'Bla bla',
          description: 'bla bla bla bla bla bla',
          lat: 1, lng: 1, user: User.first, city: City.first)
    end
    it { should validate_uniqueness_of :title }
  end

  it { should belong_to :user }
  it { should belong_to :city }

  describe "#state?" do
    context "initially" do
      before { @report = Factory(:report) }
      it "should eq waiting_moderation" do
        @report.state?(:waiting_moderation).should be_true
      end

      it "should not eq fixed e.g." do
        @report.state?(:fixed).should be_false
      end
    end

    context 'on decline' do
      before { @report = Factory(:report); @report.inactivate! }
      it "should be inactive" do
        @report.state?(:inactive).should be_true
      end
    end
  end

  describe "'active' state" do
      before do
        city = create(:city)
        create_list(:report, 3, state: 'active', city: city)
        create_list(:report, 2, state: 'waiting_confirmation', city: city)
      end
      subject { Report.active.count }
      it { should eq 5 }
  end

  [:inactive, :fixed, :waiting_moderation, :waiting_confirmation].each do |state|
    record_count = Random.new.rand(2..5)
    describe "'#{state}' state" do
      before do
        city = create(:city)
        create_list(:report, record_count, state: state, city: city)
      end
      subject { Report.send(state).count }
      it { should eq record_count }
    end
  end

  describe "states" do
    subject { @report.state }
    before { @report = Factory(:report) }
    context "initially" do
      it { should eq "waiting_moderation" }
    end

    context "when accepted" do
      before { @report.accept! }
      it { should eq "active" }
    end

    context "when declined" do
      before { @report.inactivate! }
      it { should eq "inactive" }
    end

    context "when inactivate" do
      before { @report.accept!;@report.inactivate! }
      it { should eq "inactive" }
    end

    context "when activate" do
      before { @report.accept!; @report.inactivate!; @report.activate! }
      it { should eq "active" }
    end

    it "should raise exception" do
      lambda { @report.request_fixed! }.should raise_error(Stateflow::NoTransitionFound)
    end

    # Wasting time
    # I'm sure stateflow is well tested
  end
end
