require 'bundler/setup'
Bundler.require

require 'shared'
require 'helpers'

Dir["#{File.expand_path('..', File.dirname(__FILE__))}/lib/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.include Helpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.profile_examples = 5
  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
