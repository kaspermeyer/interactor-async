$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "interactor/async"

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require "minitest/autorun"
