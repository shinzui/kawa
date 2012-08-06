# encoding: UTF-8

def new_quote
  visit new_quote_path
  fill_in "Author", with: "Miyamoto Musashi"
  fill_in "Quotation", with: "Do nothing which is of no use."
  fill_in "Source", with: "The Book of Five Rings"
end

def verify_quote
  quote = Quote.last
  quote.author.should_not be_nil
  quote.source.should_not be_nil
  page.should have_content(quote.quotation)
  page.should have_content(quote.author)
  page.should have_content(quote.source)
end

Given /^I create a new quotation$/ do 
  new_quote
  click_button :submit
end

Given /^I create a "([^"]*)" quotation$/ do |lang| 
  new_quote
  select lang, :from  => :lang
  click_button :submit
end

Then /^I should see the quotation$/ do
  verify_quote
end

Then /^the quote should be marked with the "([^"]*)" lang$/ do |lang|
  verify_quote
  page.should have_xpath("//blockquote[@lang='#{lang}']")
end

Given /^there is a quote$/ do
  @quote = Fabricate(:quote)
end

Given /^I update quotation to "([^"]*)"$/ do |new_quotation|
  @new_quotation = new_quotation
  quote = Quote.last
  visit edit_quote_path(quote)
  fill_in "Quotation", :with  => new_quotation
  click_button :submit
end

Then /^the quotation should change$/ do
  Quote.count.should == 1
  quote = Quote.last
  quote.quotation.should == @new_quotation
end

Given /^I tag the quote with "([^"]*)"$/ do |tags| 
  quote = Quote.last
  visit edit_quote_path(quote)
  fill_in "Tags", :with  => tags
  click_button :submit
end

Then /^the quote should be tagged with "([^"]*)"$/ do |tags|
  tags = tags.split("and").map(&:strip)
  Quote.last.tags_array.should == tags
end

Then /^I should be able to delete the quote$/ do
  quote = Quote.last
  quote_id = quote.id
  visit quote_path(quote)
  find(:xpath, "//a[contains(@rel, 'delete-quote')]").click
  Quote.where(:_id  => quote_id).first.should be_nil
end

Given /^there are (\d+) quotes$/ do |count|
  count.to_i.times { Fabricate(:quote) }
end

Given /^I go to quotes page$/ do
  visit quotes_path
end

Then /^I should see the quotes$/ do
  Quote.all.each do |quote|
    page.should have_content(quote.quotation)
  end
end

When /^I visit the "([^"]*)" tag quotes/ do |tag|
  tags = tag.split /\sand\s/
  visit quotes_path(:tags  => tags)
end

Given /^a quote tagged with "([^"]*)"$/ do |tags| 
  quotation = "蛙の子は蛙"
  quote = Fabricate(:quote, :tags  => tags, :quotation  => quotation)
end

Then /^I should see the "([^"]*)" tagged quote$/ do |tag|
  tags = tag.split("and").map(&:strip)
  quote = Quote.all_in(:tags_array  => tags).first
  page.should have_content(quote.quotation)
  other_quotes =  Quote.not_in(:tags_array  => tags)
  other_quotes.each do |q|
    page.should_not have_content(q.quotation)
  end
end
