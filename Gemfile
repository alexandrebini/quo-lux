source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'devise', '4.3.0'
gem 'friendly_id', '5.2.1'
gem 'materialize-form', '1.0.8'
gem 'materialize-sass', '0.100.1'
gem 'mechanize', '2.7.5'
gem 'memoist', '0.16.0'
gem 'money', '6.9.0'
gem 'paper_trail', '7.1.0'
gem 'pg', '0.21.0'
gem 'puma', '3.9.1'
gem 'rails', '5.1.3'
gem 'redis', '3.3.3'
gem 'simple_form', '3.5.0'
gem 'sucker_punch', '2.0.2'
gem 'turbolinks', '5.0.1'
gem 'tzinfo-data', platforms: %i[mingw mswin jruby x64_mingw]
gem 'uglifier', '3.2.0'
gem 'webmock', '3.0.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'guard-bundler', '~> 2.1'
  gem 'guard-bundler-audit', '~> 0.1.4'
  gem 'guard-livereload', '~> 2.5.2', require: false
  gem 'guard-migrate', '~> 2.0.0'
  gem 'guard-rspec', '~> 4.7'
  gem 'guard-rubocop', '~> 1.3'
  gem 'rspec-rails', '~> 3.6'
end

group :test do
  gem 'database_cleaner', '~> 1.6'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'faker', '~> 1.8'
  gem 'rspec-its', '~> 1.2'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'vcr', '~> 3.0'
end

group :development do
  gem 'foreman', '~> 0.84.0'
  gem 'letter_opener', '~> 1.4.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rack-livereload', '~> 0.3.16'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
