require 'spec_helper'

describe 'report state' do
  before do
    @city = create :city
  end
  subject { Report.first.state }
  context "when report is new" do
    before do
      sign_in
      current_user_is_moderator

      user = create :user
      @report = create :report, city: @city, user: user

      visit '/'
      click_link @city.name
      click_link "Waiting moderation"
      click_link @report.title
    end
    context "and moderator accepts it" do
      before { click_link 'Accept' }
      it { should eq('active') }
    end
    context "and moderation declines" do
      before { click_link 'Decline' }
      it { should eq('inactive') }
    end
  end

  context "when report is active" do
    before do
      sign_in
    end
    context "when owner inactivates" do
      before do
        @report = create :report, city: @city, user: current_user, state: :active
        visit '/'
        click_link @city.name
        click_link @report.title
        click_link 'Inactivate'
      end
      it { should eq('inactive') }
    end
    context "when other user marks as fixed" do
      before do
        @report = create :report, city: @city, user: create(:user), state: :active
        visit '/'
        click_link @city.name
        click_link @report.title
        click_link 'Mark as fixed'
      end
      it { should eq('waiting_confirmation') }
    end
  end

  context "when report is waiting confirmation" do
    before do
      sign_in
      current_user_is_moderator
      @report = create :report, city: @city, user: create(:user), state: :waiting_confirmation
      visit '/'
      click_link @city.name
      click_link 'Waiting confirmation'
      click_link @report.title
    end
    context "and moderator confirms that it's fixed" do
      before { click_link 'Confirm fixed' }
      it { should eq('fixed') }
    end
    context "and moderator declines that it's fixed" do
      before { click_link 'Decline fixed' }
      it { should eq('active') }
    end
  end

  context "when report is fixed" do
    before do
      sign_in
      current_user_is_moderator
      @report = create :report, city: @city, user: create(:user), state: :fixed
      visit '/'
      click_link @city.name
      click_link 'Fixed'
      click_link @report.title
      click_link 'Decline fixed'
    end
    it { should eq('active') }
  end

  context "when report is inactive" do
    before do
      sign_in
      current_user_is_moderator
      @report = create :report, city: @city, user: create(:user), state: :inactive
      visit '/'
      click_link @city.name
      click_link 'Inactive'
      click_link @report.title
      click_link 'Activate'
    end
    it { should eq('active') }
  end
end
