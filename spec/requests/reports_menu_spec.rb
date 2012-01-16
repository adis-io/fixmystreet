require 'spec_helper'

describe "Reports menu" do
  subject { find("//ul[@class='tabs']").all(".//a").collect(&:text) }
  before do
    @city = create(:city)
    visit '/'
  end

  context "for anonymous user" do
    before do
      click_link @city.name
    end
    it { should eq(["Active", "Fixed"]) }
  end

  context "for loggen in user" do
    before { click_link 'Sign in with Twitter' }

    context "for logged in user who hasn't moderation-waiting reports" do
      before do
        visit '/'
        click_link @city.name
      end
      it { should eq(["Active", "Fixed"]) }
    end

    context "for logged in user who has moderation-waiting reports" do
      before do
        user = User.first
        create(:report, user: user, city: @city, state: :waiting_moderation)

        visit '/'
        click_link @city.name
      end
      it { should eq(["Active", "Fixed", "Waiting moderation"]) }
    end

    context "for moderator or admin" do
      ["admin", "moderator"].each do |role|
        before do
          user = User.first
          user.update_attributes(:role => role)

          visit '/'
          click_link @city.name
        end
        it { should eq(["Active", "Fixed", "Waiting moderation", "Waiting confirmation", "Inactive"]) }
      end
    end
  end
end
