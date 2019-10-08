require "interactor"
require "interactor/async/version"

module Interactor
  module Async
    extend self

    if defined?(ActiveJob::Base)
      class ActiveJobDispatcher < ActiveJob::Base
        def perform(name, *args)
          name.constantize.call(*args)
        end
      end
    end

    class NullDispatcher
      def self.perform_later(name, *args)
        name.constantize.call(*args)
      end
    end

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
      default_options = if defined?(ActiveJob::Base)
        {job_wrapper: ActiveJobDispatcher}
      else
        {job_wrapper: NullDispatcher}
      end

      OpenStruct.new(default_options)
    end
  end
end

Interactor::ClassMethods.class_eval do
  def call_later *args
    Interactor::Async.config.job_wrapper.perform_later(name, *args)
  end
end
