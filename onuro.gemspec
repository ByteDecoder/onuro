# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onuro/version'

Gem::Specification.new do |spec|
  spec.name          = 'onuro'
  spec.version       = Onuro::VERSION
  spec.authors       = ['Rodrigo Reyes']
  spec.email         = ['encode@bytedecoder.me']

  spec.summary       = 'Ruby Workflow Engine based in events that execute a collection of rules.'
  spec.description   = 'Ruby Workflow Engine based in events that execute a collection of rules.'
  spec.homepage      = 'https://github.com/ByteDecoder/onuro'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ByteDecoder/onuro'
  spec.metadata['changelog_uri'] = 'https://github.com/ByteDecoder/onuro/blob/master/CHANGELOG.md'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #
  #   spec.metadata['homepage_uri'] = spec.homepage
  #   spec.metadata['source_code_uri'] = 'https://github.com/ByteDecoder/onuro'
  #   spec.metadata['changelog_uri'] = 'https://github.com/ByteDecoder/onuro/blob/master/CODE_OF_CONDUCT.md'
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against ' \
  #     'public gem pushes.'
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.2'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'coderay', '~> 1.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.71.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.33'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
end
