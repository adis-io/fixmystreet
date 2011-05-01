
DOMAIN = "example.com"
PORT = Capybara.server_port

Given /^I am in subdomain "(.+)"$/ do | subdomain|
  if Capybara.current_driver == :selenium
    Capybara.app_host = "#{subdomain}.#{DOMAIN}:#{PORT}"
  else
    Capybara.default_host = "#{subdomain}.#{DOMAIN}"
    switch_session(subdomain)
    visit("http://#{subdomain}.#{DOMAIN}")
  end
end

Given /^a reports:$/ do |table|
  table.hashes.each do |report|
    report[:city_id] = City.find_by_name(report[:city]).id
    report[:user] = User.find_by_email report[:user]
    Report.create! report
  end
end

Given /^I logged in$/ do
  visit path_to("the homepage")
  find(:xpath, "//a/img[@alt='Login with Facebook']/..").click
end

Then /^there should be a user:$/ do |table|
  table.hashes.each do |user_hash|
    user = User.find_by_name user_hash[:name]
    user_hash.keys.each do |key|
      user_hash[key].should == user[key]
    end
  end
end

When /^I follow image "([^"]*)"$/ do |alt|
  find(:xpath, "//a/img[@alt='#{alt}']/..").click
end

Then /^there should be reports:$/ do |table|
  table.hashes.each do |r|
    report = Report.find_by_title r[:title]
    report.description.should == r[:description]
    report.photo1?.should == true
    report.photo2?.should == true
    report.photo3?.should == true
    report.photo4?.should == true
    report.photo5?.should == true
  end
end

Given /^a user "([^"]*)"$/ do |email|
  User.create(:email => email)
end

Given /^a user "([^"]*)" with role "([^"]*)"$/ do |email, role|
  u = User.find_by_email(email)
  r = Role.create(:name => role)
  u.roles << r
end

Given /^a country "([^"]*)"$/ do |country|
  Country.create! :name => country, :lat => 1, :long => 1,
    :zoom => 1
end

Given /^cities "([^"]*)" in "([^"]*)"$/ do |cities, country|
  country = Country.find_by_name(country)
  cities.split(", ").each do |city|
    City.create! :name => city, :country_id => country,
      :lat => 1, :long => 1, :zoom => 1,
      :subdomain => city.downcase
  end
end

