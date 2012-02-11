# encoding: UTF-8

def new_link
  visit new_link_path
  fill_in "Url", with: "http://www.tnm.jp/"
  fill_in "Title", with: "東京国立博物館"
  fill_in "Description", with: "Tokyo National Museum"
end

def verify_link
  link = Link.last
  link.url.should_not be_nil
  link.title.should_not be_nil
  link.description.should_not be_nil
  page.should have_link(link.title, :href  => link.url)
  page.should have_content(link.description)
end

Given /^I create a new link$/ do
  new_link
  click_button :submit
end

Then /^I should see the link$/ do

end
