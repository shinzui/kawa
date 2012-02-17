require 'elastic_search'

Before do
  DatabaseCleaner.start
  ElasticSearch.refresh_all_indices
end

After do |scenario|
  DatabaseCleaner.clean
  ElasticSearch.delete_all_indices
end
