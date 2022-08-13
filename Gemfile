# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'
gem 'rails', '~> 6.1.5'

gem 'active_model_serializers', '~> 0.10.10'
gem 'bootsnap', require: false
gem 'devise_token_auth', '~> 1.1'
gem 'exception_notification', '~> 4.4'
gem 'kaminari', '~> 1.2'
gem 'net-smtp', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.2'
gem 'rack-cors', '~> 1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails', '~> 5.0'
end

group :development do
  gem 'bullet'
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '~> 3.3'
  gem 'rails_best_practices', require: false
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'faker', '~> 2.17'
  gem 'shoulda-matchers', '~> 4.5'
  gem 'simplecov', '~> 0.21.2', require: false
  gem "simplecov_json_formatter", "~> 0.1.4", require: false
end

