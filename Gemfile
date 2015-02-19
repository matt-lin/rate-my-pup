source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.16'

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19'
end


group :production do
  gem 'pg'
end

group :assets do
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml'


gem 'omniauth-facebook', :github => 'mkdynamic/omniauth-facebook'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions
  gem 'database_cleaner' # to clear Cucumber's test database between runs
  gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
end
