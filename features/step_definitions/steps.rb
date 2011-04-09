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

Then /^there should be a user:$/ do |table|
  table.hashes.each do |user_hash|
    user = User.find_by_name user_hash[:name]
    user_hash.keys.each do |key|
      puts key
      user_hash[key].should == user[key]
    end
  end
end