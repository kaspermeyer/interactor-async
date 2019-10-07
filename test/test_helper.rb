$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "active_job"
require "interactor/async"
require "minitest/autorun"
