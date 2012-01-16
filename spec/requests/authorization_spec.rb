require 'spec_helper'
describe "authorization" do
  context "when user logs in" do
    it "should show successful message" do
      # TODO: dup
      country = create(:country)
      create_list(:city, 1, :country => country)

      sign_in
      page.should have_content 'Successfully authorized from Twitter account.'
    end
  end
end
