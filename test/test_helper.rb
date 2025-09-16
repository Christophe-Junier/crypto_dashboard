require "simplecov"
require "simplecov_small_badge"

SimpleCov.start "rails" do
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCovSmallBadge::Formatter
  ])

  add_filter %w[
    app/helpers/application_helper.rb
    app/channels/application_cable/channel.rb
    app/jobs/application_job.rb
    app/mailers/application_mailer.rb
    app/models/application_record.rb
    app/controllers/application_controller.rb
  ]

  load Rails.root.join("app/models/user.rb")
end

SimpleCovSmallBadge.configure do |config|
  config.rounded_border = true
  config.background = "#ffffcc"
end

SimpleCov.minimum_coverage 90
SimpleCov.refuse_coverage_drop

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Erreur de loading trop rapide rails, empeche la couverture du code
# On load les fichiers après ducoup, à creuser c'est bizarre.
load Rails.root.join("app/models/user.rb")

module ActiveSupport
  class TestCase
    self.use_transactional_tests = true
    parallelize(workers: :number_of_processors)
  end
end
