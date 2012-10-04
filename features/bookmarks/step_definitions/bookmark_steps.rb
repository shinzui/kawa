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

Given /^there are (\d+) bookmakrs$/ do |count|
  count.to_i.times { Fabricate(:bookmark) }
end

Given /^I update the first bookmark$/ do
  bookmark = Bookmark .order_by(created_at: 1).first 
  bookmark.touch
end

Given /^I create a private bookmark$/ do
  new_bookmark
  check "Private"
  click_button :submit
end

Given /^I access "(.*?)" bookmark$/ do |bookmark_url|
  bookmark = Bookmark.with_url(bookmark_url).first
  bookmark.should be_present
  visit bookmark_path(bookmark)
end

And /^the bookmark should be private$/ do
  page.should have_css(".icon-lock")
  Bookmark.last.should be_private
end

And /^I should be the creator of the bookmark$/ do
  Bookmark.last.creator.should == logged_in_user
end

Then /^I should see the bookmark$/ do
  verify_bookmark
end

Given /^I go to view all bookmarks$/ do
  visit bookmarks_path
end

Then /^the bookmarks should be reversed ordered by their creation date$/ do
  Bookmark.order_by(created_at: -1).each.each_with_index do |bookmark, index|
    all("div.link div.thumbnails a")[index]["href"].should == short_url_path(bookmark)
  end
end
