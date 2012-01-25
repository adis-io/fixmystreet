require 'spec_helper'
describe "authorization" do
  context "when user logs in" do
    it "should show successful message" do
      create(:city)

      sign_in
      page.should have_content 'Successfully authorized from Twitter account.'
    end
  end
end
