Given /^a reports:$/ do |table|
  table.hashes.each do |report|
    Report.create report
  end
end

