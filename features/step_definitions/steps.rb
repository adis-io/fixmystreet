Given /^a reports:$/ do |table|
  table.hashes.each do |report|
    report[:user] = User.find_by_email report[:user]
    Report.create report
  end
end

Given /^I logged in$/ do
  visit path_to("the homepage")
  click_link("Login with Facebook")
end

