require 'spec_helper'

describe "Report showing" do
  before do
    city = create(:city)
    user = create(:user)
    @report = create(:report, city: city, user: user, state: :active)
  end

  it "should show report" do
    visit '/'
    click_link @report.city.name
    click_link @report.title
    page.should have_xpath("//h6[contains(.,'#{@report.user.name}')]")
    page.should have_xpath("//h3[contains(.,'#{@report.title}')]")
    page.should have_xpath("//div[@id='description' and contains(.,'#{@report.description}')]")
  end
end
