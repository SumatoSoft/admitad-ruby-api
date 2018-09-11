lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'admitad/version'

Gem::Specification.new do |spec|
  spec.name          = 'admitad'
  spec.version       = Admitad::VERSION
  spec.authors       = ['alexandr-senyuk']
  spec.email         = ['alexandr.030197@gmail.com']

  spec.summary       = 'Simple wrapper for admitad api'
  spec.description   = 'This interface helps you to create applications for Admitad affiliate network.
                          You can build up applications to analyze your own statistics and accounting records or
                          to put them up for sale in the Admitad App Store.'
  spec.homepage      = 'https://github.com/SumatoSoft/admitad-ruby-api'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.files                         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir                        = 'exe'
  spec.executables                   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths                 = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0'

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'httparty', '~> 0.16.2'
  spec.add_runtime_dependency 'virtus', '~> 1.0', '>= 1.0.5'
end
