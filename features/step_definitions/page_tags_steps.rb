Given /^I create a page and tag it with "([^"]*)"$/ do |tags| 
  visit new_page_path
  wiki_page = Fabricate.attributes_for(:markdown_page)
  fill_in "Name", :with  => wiki_page[:name]
  select wiki_page[:markup], :from  => :markup
  fill_in "Raw data", :with => "##Tokyo Tower\n<<tag values='#{tags}'>>"
  click_button :submit
end


Then /^it should have the "([^"]*)" tag$/ do |tag|
  Page.last.tags_array.should include(tag)
end
