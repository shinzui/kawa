Given /^I create a "([^"]*)" page in "([^"]*)"$/ do |page_name, markup|
  visit new_page_path
  wiki_page = Fabricate.attributes_for("#{markup}_page".to_sym, :name  => page_name, :markup  => markup)
  fill_in "Name", :with => wiki_page[:name] 
  select wiki_page[:markup], :from  => :markup 
  fill_in "Raw data", :with  => wiki_page[:raw_data]
  click_button :submit
end

Then /^I should see the "([^"]*)" page generated from "([^"]*)"$/ do |page_name, markup|
  wiki_page = Page.where(:name  => page_name).first
  visit page_path(wiki_page.id)
  page.should have_content(wiki_page.name)
 
  #TODO there must be an easier way to verify, also extract to helper
  doc = Nokogiri::HTML::DocumentFragment.parse(MarkupRenderer.renderer(wiki_page.markup)[wiki_page.raw_data])
  doc.traverse do |node|
    next if node.text? || !node.is_a?(Nokogiri::XML::Element)
    css_path = node.css_path.gsub(/^\? >/,'').strip
    page.should have_css(css_path, :text  => node.text)
  end
end
