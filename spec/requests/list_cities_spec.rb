require 'spec_helper'
describe "homepage" do
  it "should show list of cities" do
    country = create(:country)
    cities = create_list(:city, 3, :country => country)

    visit '/'
    cities.each do |city|
      page.should have_xpath("//ul[@id='cities']/li/h3[contains(.,'#{city.name}')]")
    end
  end
end
