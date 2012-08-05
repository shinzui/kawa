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

Before "@logged_in" do
  login_user
end
