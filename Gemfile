source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'haml-rails'
gem 'jquery-rails'
gem 'modernizr'
gem 'mysql2', '~> 0.3.11'
gem 'rack-mini-profiler'
gem 'sass'
gem 'tvdb_party'

# Gems used only for assets and not required
# in production environments by default
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'capybara'
  gem 'debugger-pry', :require => 'debugger/pry' # can get rid of this as pry-nav has most of the functionality I require
  gem 'factory_girl_rails'
  gem 'fivemat'
  gem 'launchy'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rspec-rails'

  # remote needs to come before nav in order for nav to work on remote
  # debugging sessions
  gem 'pry-remote'
  gem 'pry-nav'
end
