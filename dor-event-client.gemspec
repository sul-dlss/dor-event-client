# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dor/event/client/version'

Gem::Specification.new do |spec|
  spec.name          = 'dor-event-client'
  spec.version       = Dor::Event::Client::VERSION
  spec.authors       = ['Justin Coyne', 'Michael Giarlo']
  spec.email         = ['jcoyne@justincoyne.com', 'leftwing@alumni.rutgers.edu']

  spec.summary       = 'A client for event services provided by DOR Services App'
  spec.homepage      = 'https://github.com/sul-dlss/event-client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.0', '< 4'

  spec.add_dependency 'activesupport', '>= 4.2'
  spec.add_dependency 'bunny', '~> 2.17' # Send messages to RabbitMQ
  spec.add_dependency 'zeitwerk', '~> 2.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
