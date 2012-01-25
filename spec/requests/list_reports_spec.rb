require 'spec_helper'

describe "Report listing" do
  def visit_reports
    visit '/'
    click_link @city.name
  end

  before do
    @city = create(:city)
  end

  subject { report_list }

  describe "active and waiting confirmation" do
    before do
      @reports = create_list(:report, 3, city: @city, state: :active)
      @reports += create_list(:report, 2, city:@city, state: :waiting_confirmation)
      visit_reports
    end
    it { should eq(@reports.reverse.collect(&:title)) }
  end

  describe "fixed" do
    before do
      @reports = create_list(:report, 3, city: @city, state: :fixed)
      visit_reports
      click_link "Fixed"
    end
    it { should eq(@reports.reverse.collect(&:title)) }
  end

  describe "waiting_moderation" do
    before do
      sign_in
      @reports = create_list(:report, 3, city: @city, state: :waiting_moderation, user: User.first)
      visit_reports
      click_link "Waiting moderation"
    end
    it { should eq(@reports.reverse.collect(&:title)) }
  end

  [:inactive, :waiting_confirmation].each do |state|
    describe state.to_s do
      before do
        sign_in
        current_user_is_moderator
        @reports = create_list(:report, 3, city: @city, state: state, user: User.first)
        visit_reports
        click_link state.to_s.humanize
      end
      it { should eq(@reports.reverse.collect(&:title)) }
    end
  end
end
