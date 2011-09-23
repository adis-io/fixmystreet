Given /^I logged in as admin first time$/ do
  When 'I go to the admin page'
  And %Q{I fill in "Email" with "kalys@osmonov.com"}
  And 'I press "Sign up"'
  And %Q{I fill in "Password" with "testtest"}
  And %Q{I fill in "Password confirmation" with "testtest"}
  And 'I press "Save Admin user"'
end

Given /^a country "([^"]*)"$/ do |country|
  When 'I go to the admin page'
  And 'I follow "fixmystreet" within "#links"'
  And 'I follow "Countries"'
  And 'I follow "Add new"'
  And %Q{I fill in "Name" with "Kyrgyzstan"}
  And %Q{I fill in "Lat" with "111"}
  And %Q{I fill in "Long" with "333"}
  And %Q{I fill in "Zoom" with "10"}
  And 'I press "Create Country"'
end

Given /^cities "([^"]*)" in "([^"]*)"$/ do |cities, country|
  cities.split(", ").each do |city|
    When 'I go to the admin page'
    And 'I follow "fixmystreet" within "#links"'
    And 'I follow "Cities"'
    And 'I follow "Add new"'
    And %Q{I fill in "Name" with "#{city}"}
    And %Q{I fill in "Lat" with "111"}
    And %Q{I fill in "Long" with "333"}
    And %Q{I fill in "Zoom" with "10"}
    And %Q{I fill in "Subdomain" with "#{city.downcase}"}
    And %Q{I select "#{country}" from "Country"}
    And 'I press "Create City"'
  end
end

