source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'rails', '~> 6.1.2', '>= 6.1.2.1'

gem 'active_model_serializers', '~> 0.10.10'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise_token_auth', '~> 1.1'
gem 'kaminari', '~> 1.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem "exception_notification", "~> 4.4"

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker', '~> 2.13'
  gem 'shoulda-matchers', '~> 4.3'
  gem 'simplecov', '~> 0.18.5', require: false
end
