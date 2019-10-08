module Interactor
  module Async
    if defined?(ActiveJob::Base)
      class ActiveJobDispatcher < ActiveJob::Base
        def perform(name, *args)
          name.constantize.call(*args)
        end
      end
    end
  end
end

