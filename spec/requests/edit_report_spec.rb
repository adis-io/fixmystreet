require 'spec_helper'

describe "report editing" do
  it "allows users to update report information" do
    report_attrs = {
      description: Faker::Lorem.sentence(10),
      title: Faker::Lorem.sentence(5),
      lat: Faker::Geolocation.lat.to_s,
      lng: Faker::Geolocation.lng.to_s
    }
    city = create :city
    sign_in
    report = create :report, user: current_user, state: :active, city: city
    visit '/'
    click_link city.name
    click_link report.title
    click_link 'Edit'
    fill_in 'Description', with: report_attrs[:description]
    fill_in 'Title', with: report_attrs[:title]
    fill_in 'Lat', with: report_attrs[:lat]
    fill_in 'Lng', with: report_attrs[:lng]
    click_button 'Save'
    report = Report.first
    [:title, :lat, :lng, :description].each do |field|
      report.send(field).should == report_attrs[field]
    end
  end
end
