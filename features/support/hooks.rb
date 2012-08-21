require 'elastic_search'

Before do
  DatabaseCleaner.start
  ElasticSearch.refresh_all_indices
end

After do |scenario|
  DatabaseCleaner.clean
  ElasticSearch.delete_all_indices
  Warden.test_reset!
end

AfterStep "@debugging" do
  debugger
  save_and_open_page
end

Before "@logged_in" do
  login_user
end
