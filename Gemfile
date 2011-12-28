source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'haml'
gem 'jquery-rails'

gem 'sqlite3', :groups => [:development, :test, :cucumber]
gem 'pg', :group => :production # For Heroku

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'haml-rails'
end

group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec-rails'
  gem 'jasmine'
end

group :test do
  gem 'factory_girl_rails'
  gem 'simplecov', :require => false
  gem 'spork', '~> 0.9.0.rc'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber-rails-training-wheels'
  gem 'capybara'
end

# Gems to exclude when using Linux
# Use: bundle install --without osxtest
group :osxtest do
  gem 'autotest'
  gem 'autotest-rails-pure'
  gem "autotest-fsevent"
end
