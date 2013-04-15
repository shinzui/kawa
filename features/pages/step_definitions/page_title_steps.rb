Then /^the page header should be "([^"]*)"$/ do |header| 
  within(:css, ".page-data > header > h1:first-child") do
    page.should have_content(header)
  end
end

Then /^the page title should be "([^"]*)"$/ do |title| 
  page.title.should == title
end
