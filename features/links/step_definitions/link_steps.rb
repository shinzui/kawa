Given /^there is a Link$/ do 
  @link = Fabricate(:link)
end

Given /^I visit the link short url$/ do
  visit link_path(@link.id)
end

Then /^I should be redirected to the link's url$/ do 
 link = Link.last
 current_url.should match (/^#{link.url}/)
end

Then /^I should record the visit to the link$/ do
  link = Link.last
  link.visits.count.should == 1
end
