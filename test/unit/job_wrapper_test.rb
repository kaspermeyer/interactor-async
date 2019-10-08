require "test_helper"

class JobWrapperTest < ActiveJob::TestCase
  def test_default_job_is_an_active_job_if_defined
    assert_equal ActiveJob::Base, Interactor::Async::DispatcherJob.superclass
  end

  def test_raising_error_if_no_job_wrapper_is_defined
    skip "To be implemented"
  end
end
