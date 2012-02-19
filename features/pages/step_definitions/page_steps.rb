Given /^there is (?:a|an) "([^"]*)" Page$/ do |page_name|
  @page = Fabricate(:markdown_page, :name  => page_name)
end

Given /^I create (?:a|an) "([^"]*)" page in "([^"]*)"$/ do |page_name, markup|
  visit new_page_path
  wiki_page = Fabricate.attributes_for("#{markup}_page".to_sym, :name  => page_name, :markup  => markup)
  fill_in "Name", :with => wiki_page[:name] 
  select wiki_page[:markup], :from  => :markup 
  fill_in "Raw data", :with  => wiki_page[:raw_data]
  click_button :submit
end

Then /^I should see the page generated$/ do
  wiki_page = Page.last
  visit page_path(wiki_page)
  page.should have_content(wiki_page.name)
 
  #TODO there must be an easier way to verify, also extract to helper
  doc = Nokogiri::HTML::DocumentFragment.parse(MarkupRenderer.renderer(wiki_page.markup)[wiki_page.raw_data])
  doc.traverse do |node|
    next if node.text? || !node.is_a?(Nokogiri::XML::Element)
    css_path = node.css_path.gsub(/^\? >/,'').strip
    page.should have_css(css_path, :text  => node.text)
  end
end

Then /^I should be able to access the page from a user friendly url$/ do
  wiki_page = Page.last
  visit page_path(wiki_page.slug)
end

Given /^I access the "([^"]*)" page$/ do |page_name| 
  wiki_page = Page.where(name: page_name).first
  wiki_page ? visit(page_path(wiki_page)) : visit(page_path(id: page_name))
end

Given /^I update the Page name to "([^"]*)"$/ do |new_page_name|
  @new_page_name = new_page_name
  wiki_page = Page.last
  visit edit_page_path(wiki_page)
  fill_in "Name", :with  => new_page_name
  click_button :submit
end

Then /^the Page name should change$/ do 
  wiki_page = Page.last
  wiki_page.name.should == @new_page_name
end

Given /^there are (\d+) Pages$/ do |count|
  count.to_i.times { Fabricate(:markdown_page) }
end

Given /^I go to the index page$/ do
  visit pages_path
end

Then /^I should see a link to all pages$/ do
  Page.all.each do |wiki_page|
    page.should have_xpath('//a', :text  => wiki_page.name)
  end
end

Then /^I should be able to delete the page$/ do
  wiki_page = Page.last
  visit page_path(wiki_page)
  find(:xpath, "//a[contains(@rel, 'delete-page')]").click
  Page.where(:id  => wiki_page.id).should be_empty
end

Then /^I should be redirected to the create "([^"]*)" page$/ do |page_name| 
  page.current_path.should == new_page_path
  field = find_field "Name"
  field.value.should == page_name
end

Given /^the page:$/ do |table| 
  page_attributes = table.hashes
  page_attributes.each { |attr| Fabricate(:page, attr) }
end
