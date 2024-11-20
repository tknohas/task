source "https://rubygems.org"

gem "rails", "~> 8.0.0"

gem "propshaft"
gem "sqlite3"
gem "puma"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "bcrypt"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "haml-rails"
gem "simple_form"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
end

group :development do
  gem "web-console"
  gem 'sgcop', github: 'SonicGarden/sgcop'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end
