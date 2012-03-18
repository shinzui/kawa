# encoding: UTF-8

def new_bookmark
  visit new_bookmark_path
  fill_in "Url", with: "http://www.tnm.jp/"
  fill_in "Title", with: "東京国立博物館"
  fill_in "Description", with: "Tokyo National Museum"
end

def verify_bookmark
  bookmark = Bookmark.last
  bookmark.url.should_not be_nil
  bookmark.title.should_not be_nil
  bookmark.description.should_not be_nil
  page.should have_link(bookmark.title, :href  => short_url_path(bookmark))
  page.should have_content(bookmark.description)
end

Given /^I create a new bookmark$/ do
  new_bookmark
  click_button :submit
end

Then /^I should see the bookmark$/ do
  verify_bookmark
end
