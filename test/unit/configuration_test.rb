require "test_helper"

class ConfigurationTest < ActiveJob::TestCase
  def teardown
    Interactor::Async.reset_config!
  end

  def test_configuring_job_wrapper
    Interactor::Async.configure do
      config.job_wrapper = TestJobWrapper
    end

    assert_equal TestJobWrapper, Interactor::Async.config.job_wrapper
  end

  def test_using_configured_job_wrapper
    Interactor::Async.configure do
      config.job_wrapper = TestJobWrapper
    end

    assert_enqueued_jobs 1, only: TestJobWrapper do
      AsyncInteractor.call_later
    end
  end

  def test_using_active_job_wrapper_as_default_if_defined
    assert defined?(ActiveJob)
    assert_equal ActiveJob::Base, Interactor::Async.config.job_wrapper.superclass
  end

  class TestJobWrapper < ActiveJob::Base
    def perform name
    end
  end

  class AsyncInteractor
    include ::Interactor

    def call
    end
  end
end
