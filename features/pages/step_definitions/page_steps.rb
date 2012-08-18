Given /^there is (?:a|an) "([^"]*)" Page$/ do |page_name|
  @page = Fabricate(:markdown_page, :name  => page_name)
end

Given /^there is (?:a|an) "([^"]*)"( private)? page created by "([^"]*)"$/ do |page_name, private, user|
  author = User.where(email: user).first || Fabricate(:user, email: user)
  private_page = private ? true : false
  wiki_page = Fabricate(:markdown_page, :name  => page_name, :author  => author, :private  => private_page)
end

Given /^I create (?:a|an)( private)? "([^"]*)" page in "([^"]*)"$/ do |private_page, page_name, markup|
  visit new_page_path
  wiki_page = Fabricate.attributes_for("#{markup}_page_with_links".to_sym, :name  => page_name)
  fill_in "Name", :with => wiki_page[:name] 
  fill_in "Raw data", :with  => wiki_page[:raw_data]
  check "Private" if private_page
  click_button :submit
end

Given /^I create (?:a|an)( private)? "([^"]*)" page with the following links:$/ do |private_page, page_name, links|
  visit new_page_path
  wiki_page = Fabricate.attributes_for(:markdown_page, :name  => page_name)
  wiki_raw_data = wiki_page[:raw_data]
  links.hashes.each do |link_info|
    wiki_raw_data << "\n[#{link_info['title']}](#{link_info['url']})\n"
  end
  fill_in "Name", :with => wiki_page[:name] 
  fill_in "Raw data", :with  => wiki_page[:raw_data]
  check "Private" if private_page
  click_button :submit
end

Then /^the "(.*?)" link should be "(.*?)"$/ do |link_url, privacy|
  links = Link.where(data: link_url)
  links.count.should == 1
  case privacy
  when "private"
    links.first.should be_private
  when "public"
    links.first.should_not be_private
  else
    fail "Unsupported privacy #{privacy}"
  end
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

Then /^I should be the author of the page$/ do
  wiki_page = Page.last
  wiki_page.author.should == logged_in_user
end

Then /^I should be able to access the page from a user friendly url$/ do
  wiki_page = Page.last
  visit page_path(wiki_page.slug)
end

Given /^I access the "([^"]*)" page$/ do |page_name| 
  wiki_page = Page.where(name: page_name).first
  wiki_page ? visit(page_path(wiki_page)) : visit(page_path(id: page_name))
end

Then /^the page should be private$/ do
  Page.last.should be_private
end

Then /^the page links should( not)? be private$/ do |public_links|
  wiki_page = Page.last
  wiki_page.should have_at_least(1).links
  wiki_page.links.each do |link|
    public_links ? link.should_not(be_private) : link.should(be_private)
  end
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

Then /^I should not see a link to the "(.*?)" page$/ do |page_name|
  wiki_page = Page.named(page_name).first
  wiki_page.should be_present
  page.should_not have_xpath('//a', :text  => wiki_page.name)
end

Then /^I should be able to delete the page$/ do
  wiki_page = Page.last
  visit page_path(wiki_page)
  find(:xpath, "//a[contains(@rel, 'delete-page')]").click
  Page.where(:_id  => wiki_page.id).first.should be_nil
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

Then /^I should be redirected to the homepage$/ do
  on_home_page = current_url == root_url || current_url == CGI.unescape(new_page_url(page: {name: "home"}))
  on_home_page.should be_true, "Expected to be on homepage was on #{current_url}"
end
