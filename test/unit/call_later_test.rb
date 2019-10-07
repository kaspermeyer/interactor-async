require "test_helper"

class CallLaterTest < ActiveJob::TestCase
  def setup
    Stateful.reset
  end

  def test_offloads_to_a_background_job
    assert_enqueued_jobs 1 do
      AsyncInteractor.call_later
    end
  end

  def test_invokes_call_on_interactor
    assert_changes -> { Stateful.touched? }, from: false, to: true do
      perform_enqueued_jobs do
        AsyncInteractor.call_later
      end
    end
  end

  class Stateful
    class << self
      def touch
        @touched = true
      end

      def touched?
        @touched
      end

      def reset
        @touched = false
      end
    end
  end

  class AsyncInteractor
    include ::Interactor
    include ::Interactor::Async

    def call
      Stateful.touch
    end
  end
end
