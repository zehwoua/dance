source 'https://rubygems.org'

gem 'rails', '3.2.13'
ruby "1.9.3"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Authorization
gem 'devise'
# Gateaway
gem 'braintree', '>= 2.16.0'
gem 'json'
#fancybox
gem 'fancybox2-rails', '~> 0.2.4'
#validations
gem 'client_side_validations'
#pdf
gem 'pdfkit'
#pagination
gem 'will_paginate'
#search
gem 'ransack'

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

gem 'jquery-rails'
#ajax image upload
gem 'remotipart'

group :development, :test do
	gem 'rspec-rails', "~> 2.0"
	gem 'factory_girl_rails'

  gem 'cucumber'
  gem 'webrat'
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
