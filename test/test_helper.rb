ENV["RAILS_ENV"] ||= "test"

require "simplecov"
require 'simplecov_small_badge'

SimpleCov.start "rails" do 
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCovSmallBadge::Formatter
  ])
end

SimpleCovSmallBadge.configure do |config|
  # does not created rounded borders
  config.rounded_border = true
  # set the background for the title to darkgrey
  config.background = '#ffffcc'
end

SimpleCov.minimum_coverage 90
SimpleCov.refuse_coverage_drop

require_relative "../config/environment"
require "rails/test_help"


module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
