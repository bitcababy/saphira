Given /^the following file_items:$/ do |file_items|
  Saphira::FileItem.create!(file_items.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) file_item$/ do |pos|
  visit file_items_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following file_items:$/ do |expected_file_items_table|
  expected_file_items_table.diff!(tableish('table tr', 'td,th'))
end

When /^I attach the file "([^"]*)"$/ do |file|
  attach_file(:file, File.expand_path('../../support/files/'+file, __FILE__))
end