ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'

Capybara.default_driver = :rack_test

RSpec.configure do |config|
  config.mock_with :rspec
end
