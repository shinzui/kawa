Given /^there is a Link$/ do 
  @link = Fabricate(:link)
end

Given /^there is a private "(.*?)" to "(.*?)" created by "(.*?)"$/ do |link_type, link_url, creator|
  user = User.where(email: creator).first || Fabricate(:user, email: creator)
  Fabricate(link_type.to_sym, url: link_url, private: true, creator: user)
end

Given /^I visit the link short url$/ do
  visit short_url_path(@link.id)
end

Given /^I go the link index page$/ do
  visit links_path
end

Then /^I should not see a link to "(.*?)"$/ do |link_url|
  page.should_not have_link(link_url)
end

Given /^I access "(.*?)" link$/ do |link_url|
  link = Link.with_url(link_url).first
  link.should be_present
  visit link_path(link)
end

Then /^I should be redirected to the link's url$/ do 
 link = Link.last
 current_url.should match (/^#{link.url}/)
end

Then /^I should record the visit to the link$/ do
  link = Link.last
  link.visits.count.should == 1
end
