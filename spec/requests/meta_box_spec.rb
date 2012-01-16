require 'spec_helper'

describe "Meta box on show report page" do
  def report_links
    report = create(:report, {city: @city}.merge(@report_opts) )
    visit '/'
    click_link @city.name
    click_link @report_opts[:state].to_s.humanize
    click_link report.title
    all("//div[@class='meta']/a").collect(&:text)
  end

  subject { report_links }

  before do
    @city = create(:city);
  end

  context "when no user is logged in" do
    context "and report is active" do
      before { @report_opts = {state: :active, user: create(:user)} }
      it { should eq(["Mark as fixed"]) }
    end

    context "and report is fixed" do
      before { @report_opts = {state: :fixed, user: create(:user)} }
      it { should eq([]) }
    end
  end

  context "when current user is owner" do
    before { sign_in }
    context "and report is waiting moderation" do
      before { @report_opts = {state: :waiting_moderation, user: current_user} }
      it { should eq(["Edit", "Inactivate"]) }
    end
    context "and report is active" do
      before { @report_opts = {state: :active, user: current_user} }
      it { should eq(["Mark as fixed", "Edit", "Inactivate"]) }
    end
    context "and report is fixed" do
      before { @report_opts = {state: :fixed, user: current_user} }
      it { should eq(["Edit", "Inactivate"]) }
    end
  end

  context "when current user is not owner" do
    before { sign_in }
    context "and report is active" do
      before { @report_opts = {state: :active, user: create(:user)} }
      it { should eq(["Mark as fixed"]) }
    end
    context "and report is fixed" do
      before { @report_opts = {state: :fixed, user: create(:user)} }
      it { should eq([]) }
    end
  end

  context "when current user is moderator" do
    before { sign_in; current_user_is_moderator }
    context "and report is waiting moderation" do
      before { @report_opts = {state: :waiting_moderation, user: create(:user)} }
      it { should eq(["Edit", "Inactivate", "Accept", "Decline"]) }
    end
    context "and report is active" do
      before { @report_opts = {state: :active, user: create(:user)} }
      it { should eq(["Mark as fixed", "Edit", "Inactivate"]) }
    end
    context "and report is waiting confirmation" do
      before { @report_opts = {state: :waiting_confirmation, user: create(:user)} }
      it { should eq(["Edit", "Inactivate", "Confirm fixed", "Decline fixed"]) }
    end
    context "and report is inactive" do
      before { @report_opts = {state: :inactive, user: create(:user)} }
      it { should eq(["Edit", "Activate"]) }
    end
  end
end
