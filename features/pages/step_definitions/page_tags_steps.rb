Given /^I create a page and tag it with "([^"]*)"$/ do |tags| 
  visit new_page_path
  wiki_page = Fabricate.attributes_for(:markdown_page)
  fill_in "Name", :with  => wiki_page[:name]
  fill_in "Raw data", :with => "##Tokyo Tower\n<<tag values='#{tags}'>>"
  click_button :submit
end

Given /^the page is tagged with "(.*?)"$/ do |tags|
  wiki_page = Page.last
  wiki_page.tags = tags
  wiki_page.save
end

Then /^it should have the "([^"]*)" tag$/ do |tag|
  Page.last.tags_array.should include(tag)
end

Given /^the "([^"]*)" page is tagged with "([^"]*)"$/ do |page_name, tag|
  Fabricate(:markdown_page, :name  => page_name, :tags  => tag)
end

When /^I visit the "([^"]*)" tag page$/ do |tag|
  tags = tag.split /\sand\s/
  visit pages_path(:tags  => tags)
end

Then /^I should see a link to the "([^"]*)" page$/ do |page_name|
  wiki_page = Page.where(name: page_name).first
  page.should have_link(page_name, :href  => page_path(wiki_page))
  Page.where(:name.ne  => page_name).each do |other_page|
    within(:css, ".main") do
      page.should_not have_link(other_page.name, :href  => page_path(other_page))
    end
  end
end

When /^I visit the page tags page$/ do
  visit page_tags_path
end

Then /^I should see a link to the "([^"]*)" tag page$/ do |tag| 
  page.should have_link(tag, :href  => pages_path(:tag  => tag))
end

