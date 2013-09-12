source 'https://rubygems.org'

gem 'rails', '3.2.13'
ruby "1.9.3"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Authorization
gem 'devise'
gem 'haml-rails'
# Gateaway
gem 'braintree-rails', :github => "lyang/braintree-rails", :branch => 'master'
gem 'simple_form'
gem 'json'
# fancybox
# gem 'fancybox2-rails', '~> 0.2.4'
#validations
gem 'client_side_validations'
gem 'carmen-rails'
#pdf
gem 'pdfkit'
#pagination
gem 'will_paginate', '~> 3.0'
#search
gem "ransack", github: "ernie/ransack"

gem 'shareable'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-glyphicons'
  gem 'uglifier', '>= 1.0.3'

  gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails',
                              :branch => '3.0.0'
end

gem 'jquery-rails', '2.1.4'
#ajax image upload
gem 'remotipart'

gem 'thin'

group :development, :test do
	gem 'rspec-rails', "~> 2.0"
	gem 'factory_girl_rails'

  gem 'cucumber'
  gem 'webrat'
end

group :development do
  gem 'mysql2'
end

group :production do
  gem 'pg'
end
gem 'rails_12factor', group: :production
# Image uploading
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
