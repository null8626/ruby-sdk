# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "topgg"
  spec.version = "2.0.0"
  spec.authors = ["Adonis Tremblay"]
  spec.email = ["rhydderchc@gmail.com"]

  spec.summary = "A top.gg api wrapper for ruby."
  spec.description = "This is a ruby library of the top.gg API."
  spec.homepage = "https://github.com/Top-gg-Community/ruby-sdk"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.glob("lib/**/*")
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
