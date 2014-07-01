require 'bundler/setup'
Bundler.setup

require 'recurring-dates'
require 'timecop'
require 'rspec'


RSpec::configure do |config|
  config.color     = true
  config.formatter = :documentation # :progress, :html, :textmate
  config.expect_with :rspec do |c|
    c.syntax = :expect # don't have should and expect syntax
  end
end
