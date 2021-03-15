source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '~> 2.7'
# gem 'rails', '4.2.10'
gem 'rails', '>= 6.1.3', '< 7.0'

gem 'puma'
gem 'em-hiredis'
# gem 'redis'
gem 'redis', '~> 3.0'

gem 'pg', '~> 1.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Terser as compressor for JavaScript assets
gem 'terser', '>= 1.1'
# Use CoffeeScript for .coffee assets and views
# TODO(etm): Do we really want to use coffee script?
gem 'coffee-rails', '~> 4.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.1', group: :doc

gem 'devise', github: 'plataformatec/devise'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'ZenTest' 
  gem 'launchy'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 4.0'
  gem 'listen'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
end

end

