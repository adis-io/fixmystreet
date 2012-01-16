require 'spec_helper'

describe "creating a new report" do
  it "should show report with successful notification" do
    city = create(:city)
    title = Faker::Lorem.sentence(5)
    desc = Faker::Lorem.sentence(10)

    sign_in
    select city.name, :from => 'City'
    fill_in 'Title', :with => title
    fill_in 'Description', :with => desc
    fill_in 'Lat', :with => Faker::Geolocation.lat
    fill_in 'Lng', :with => Faker::Geolocation.lng
    click_button 'Save'
    find(:css, "h3").text.should == title
    find(:css, "#description").text.should == desc
  end
end
