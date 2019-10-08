module Interactor
  module Async
    class NullDispatcher
      def self.perform_later(name, *args)
        name.constantize.call(*args)
      end
    end
  end
end
