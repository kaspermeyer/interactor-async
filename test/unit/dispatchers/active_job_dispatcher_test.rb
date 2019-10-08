require "test_helper"

class ActiveJobDispatcherTest < ActiveJob::TestCase
  def test_executes_interactor_in_a_background_job
    assert_enqueued_jobs 1 do
      Interactor::Async::ActiveJobDispatcher.perform_later ActiveJobInteractor.name
    end
  end

  class ActiveJobInteractor
    include ::Interactor

    def call
    end
  end
end
