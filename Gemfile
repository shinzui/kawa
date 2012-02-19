source 'http://rubygems.org'

gem 'rails', '3.2.1'
gem 'mongoid'
gem 'bson_ext'
gem 'mongoid_slug', :git  => 'git@github.com:shinzui/mongoid-slug.git'
gem 'mongoid_taggable_with_context', :git  => 'git@github.com:shinzui/mongoid_taggable_with_context.git'
gem 'mongoid_rails_migrations'

gem 'nokogiri'
gem 'redcarpet', :git  => 'git://github.com/tanoku/redcarpet.git'
gem 'creole'
gem 'crummy', '~> 1.3.6'
#gem 'idn'
gem 'tire'
gem 'tire-contrib'
gem 'yajl-ruby'
gem 'loofah'
gem 'mustache'
gem 'postrank-uri'
gem 'pygments.rb'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

group :development do
  gem 'awesome_print'
  gem 'guard'
  gem "guard-rspec"
  gem "guard-cucumber"
  gem "guard-shell"
  gem "guard-bundler"
  gem "rb-fsevent", :require  => false
  gem "growl", :require  => false
  gem "yard"
  gem "pry-rails"
  gem "pry-doc"
end


group :test do
  gem 'cucumber-rails'
  gem "rspec-rails"
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'mongoid-rspec'
  gem 'launchy'
  gem 'capybara-webkit'
  gem 'webmock', :require  => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'jquery-rails'
gem 'less-rails-bootstrap'
gem 'chosen-rails'
gem 'ajax-chosen-rails'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
gem 'unicorn'

group :test, :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
end

