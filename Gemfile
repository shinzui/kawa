source 'http://rubygems.org'

gem 'rails', '4.0.0'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'mongoid', :github  => "mongoid/mongoid", :branch  => "master"
gem 'mongoid_slug'
gem 'mongoid_taggable_with_context'#, :git  => 'git@github.com:shinzui/mongoid_taggable_with_context.git'
gem 'mongoid_rails_migrations'

gem 'nokogiri'
gem 'redcarpet'
gem 'creole'
gem 'crummy'
gem 'tire', github: "karmi/tire"
gem 'tire-contrib'
gem 'yajl-ruby'
gem 'loofah'
gem 'mustache'
gem 'postrank-uri'
gem 'carrierwave'
gem "carrierwave-mongoid"
gem "mime-types"
gem 'mini_magick'
gem "js-routes"
gem 'sidekiq'
gem 'kiqstand', github: "mongoid/kiqstand"
gem "pygments.rb"
gem "configatron"
gem "slim"
gem "sinatra", :require => nil
gem "devise"
gem "authority"
gem "kaminari"
gem "select2-rails"
gem "kaminari-bootstrap", github: "mcasimir/kaminari-bootstrap" 
gem "active_model_serializers", :git => "git://github.com/rails-api/active_model_serializers.git"
gem "protected_attributes"
gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => '3'
gem "font-awesome-rails"
gem 'dropzonejs-rails'

#sidekiq UI
gem "slim"
gem "sinatra", :require  => nil

group :development do
  gem 'awesome_print'
  gem 'guard'
  gem "guard-rspec"
  gem "guard-cucumber"
  gem "guard-shell"
  gem "guard-bundler"
  gem "guard-pow"
  gem 'guard-konacha'
  gem "rb-fsevent", :require  => false
  gem "terminal-notifier"
  gem "yard"
  gem "pry-rails"
  gem "pry-doc"
  gem "pry-remote"
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
end


group :test do
  gem 'cucumber-rails' #, github: 'cucumber/cucumber-rails', branch: 'master_rails4_test'
  gem "rspec-rails"
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'mongoid-rspec'
  gem 'launchy'
  gem 'poltergeist'
  gem 'webmock', :require  => false
  gem 'cucumber-api-steps', :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'
  
  gem 'uglifier'
  gem 'therubyracer'
  gem 'ejs'
  gem 'eco'
end

gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
gem 'unicorn'

group :test, :development do
  gem 'konacha'
  gem 'debugger', :require => 'ruby-debug'
end

