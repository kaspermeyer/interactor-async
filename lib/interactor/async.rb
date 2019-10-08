require "interactor"
require "interactor/async/version"

module Interactor
  module Async
    if defined?(ActiveJob::Base)
      class Dispatcher < ActiveJob::Base
        def perform(name, *args)
          name.constantize.call(*args)
        end
      end
    end

    class << self
      def configure &block
        instance_eval(&block)
      end

      def config
        @config ||= default_config
      end

      def reset_config!
        @config = default_config
      end

      def default_config
        default_options = if defined?(Dispatcher)
          {job_wrapper: Dispatcher}
        else
          {}
        end

        OpenStruct.new(default_options)
      end

      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def call_later *args
        Interactor::Async.config.job_wrapper.perform_later(name, *args)
      end
    end
  end
end
