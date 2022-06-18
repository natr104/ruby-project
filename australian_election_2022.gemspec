# frozen_string_literal: true

require_relative "lib/australian_election_2022/version"

Gem::Specification.new do |spec|
  spec.name = "australian_election_2022"
  spec.version = AustralianElection2022::VERSION
  spec.authors = ["Nathan Troy"]
  spec.email = ["nathan.troy.dev@gmail.com"]

  spec.summary = "Australian Federal Election 2022 Results Tracker."
  spec.description = "A CLI application to view results from the 2022 Australian Federal Election."
  spec.homepage = "https://github.com/natr104/ruby-project"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"


  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
