Given /^the following image_variants:$/ do |image_variants|
  ImageVariant.create!(image_variants.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) image_variant$/ do |pos|
  visit image_variants_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following image_variants:$/ do |expected_image_variants_table|
  expected_image_variants_table.diff!(tableish('table tr', 'td,th'))
end

Given /^the image_variant "([^"]*)" exists$/ do |name|
  Given 'I am on "/admin/saphira/files"'
  Given 'I follow "image variants" within ".menu"'
  Given 'I follow "New Image variant"'
  Given 'I fill in "image_variant_name" with "'+name+'"'
  Given 'I press "Create Image variant"'
end

Given /^the image "([^"]*)" is uploaded$/ do |file|
  current_path = page.current_path
  Given 'I am on "/admin/saphira/files"'
  Given 'I follow "New File"'
  Given 'I attach the file "'+file+'"'
  Given 'I press "Create"'
  visit current_path
end
