# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monee/version'

Gem::Specification.new do |spec|
  spec.name          = "monee"
  spec.version       = Monee::VERSION
  spec.authors       = ["beck03076"]
  spec.email         = ["senthilkumar.hce@gmail.com"]

  spec.summary       = %q{ This is a rubygem created with minimal features as required and engineered with very simple techniques showcasing few good practices in building a ruby project. }
  spec.description   = %q{ Following TDD practice, designed with few useful patterns, styled with rubocop style guide, documented with yard convention, lines of code analysis, 100% tests coverage and properly error handled rubygem project could be very useful to assess one's knowledge in build rubygems. }
  spec.homepage      = "https://github.com/beck03076/monee"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
end
