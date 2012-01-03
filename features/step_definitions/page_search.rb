Given /^I search for "([^"]*)"$/ do |search_term|
  #ensure there is a search index
  Page.create_search_index
  visit root_path
  within(:css, ".form-search") do
    fill_in 'query', :with  => search_term
  end
  page.execute_script("$('form.form-search').submit()")
end

Then /^I should get a link to the "([^"]*)" page$/ do |page_name|
  wiki_page = Page.where(:name  => page_name).first
  page.should have_link(wiki_page.name, :href  => page_path(wiki_page))
  Page.excludes(name: page_name).each do |non_matching_page|
    page.should_not have_link(non_matching_page.name, :href  => page_path(non_matching_page))
  end
end

Then /^I should see a friendly search error page$/ do
  page.should have_content("Sorry, your query")
end

Then /^I should see a button to create the "([^"]*)" Page$/ do |page_name|
  page.should have_link "Create #{page_name}", :href  => new_page_path(page: {name: page_name})
end
