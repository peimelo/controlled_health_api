source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'

gem 'active_model_serializers', '~> 0.10.10'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise_token_auth', '~> 1.1'
gem 'kaminari', '~> 1.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rack-cors', '~> 1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'letter_opener', '~> 1.7'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker', '~> 2.13'
  gem 'shoulda-matchers', '~> 4.3'
  gem 'simplecov', '~> 0.18.5', require: false
end
