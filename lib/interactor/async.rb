require "interactor"
require "interactor/async/version"
require "interactor/async/null_dispatcher"
require "interactor/async/active_job_dispatcher"

module Interactor
  module Async
    extend self

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
