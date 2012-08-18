Given /^I create an interwiki link to "([^"]*)" from the "([^"]*)" Page$/ do |linked_page_name, page_name| 
  linked_page_name = linked_page_name == "it" ? @page.name : linked_page_name
  visit new_page_path
  wiki_page = Fabricate.attributes_for(:markdown_page, :name  => page_name)
  fill_in "Name", :with  => wiki_page[:name]
  fill_in "Raw data", :with  => "##{wiki_page[:name]}\n\n [[#{linked_page_name}]]"
  click_button :submit
end

Then /^I should see a link to the "([^"]*)" page on the "([^"]*)" page$/ do |interwiki_page, page_name|
  wiki_page = Page.where(:name  => page_name).first
  visit page_path(wiki_page)
  linked_page = Page.where(:name  => interwiki_page).first || Page.new(:name  => interwiki_page)
  page.should have_link(linked_page.name, :href  => PageRenderer.linked_page_path(linked_page))
end
