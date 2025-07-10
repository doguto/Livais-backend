source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Alphabet sort
gem "annotaterb"
gem "bootsnap", require: false
gem "dotenv-rails"
gem "enumerize"
gem 'google-id-token'
gem "jwt", "~> 3.1"
gem "kamal", require: false
gem "openai", "~> 0.11.0"
gem "rack-cors"
gem "rubocop", require: false
gem "ruby-lsp"
gem "ruby-openai"
gem "sentry-ruby"
gem "sentry-rails"
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "bcrypt", "~> 3.1.7"
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "faker"
  gem "rubocop-rails-omakase", require: false
  gem "sqlite3", "~> 2.6"
end

group :production do
  gem "mysql2", ">= 0.5.3"
end
