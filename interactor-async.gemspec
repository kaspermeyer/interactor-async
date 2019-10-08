lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "interactor/async/version"

Gem::Specification.new do |spec|
  spec.name = "interactor-async"
  spec.version = Interactor::Async::VERSION
  spec.authors = ["Kasper Meyer"]
  spec.email = ["hi@kaspermeyer.com"]

  spec.summary = "Asynchronous interactors"
  spec.description = "Off-load interactors to a background job with `call_later`."
  spec.homepage = "https://github.com/kaspermeyer/interactor-async"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "interactor", "~> 3.0"
  spec.add_development_dependency "activejob", "> 4.2"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "standard"
end
