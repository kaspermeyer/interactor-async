require "test_helper"

class NullDispatcherTest < ActiveJob::TestCase
  def test_executes_interactor_inline
    assert_enqueued_jobs 0 do
      Interactor::Async::NullDispatcher.perform_later NullInteractor.name
    end
  end

  class NullInteractor
    include ::Interactor

    def call
    end
  end
end
