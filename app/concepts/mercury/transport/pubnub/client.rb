# frozen_string_literal: true

module Mercury
  module Transport
    module Pubnub
      class Client < SimpleDelegator
        include Singleton

        class << self
          def method_missing(method, *args, &block)
            if instance.respond_to?(method)
              instance.send(method, *args, &block)
            else
              super
            end
          end

          def respond_to_missing?(method, include_private = false)
            instance.respond_to?(method, include_private) || super
          end
        end

        def initialize
          logger = Logger.new(Rails.root.join('log', 'pubnub.log'))
          logger.level = Logger.const_get(ENV.fetch('LOG_LEVEL', 'INFO').upcase)

          @client = ::Pubnub.new(
            subscribe_key: ENV.fetch('PUBNUB_SUBSCRIBE_KEY'),
            publish_key: ENV.fetch('PUBNUB_PUBLISH_KEY'),
            secret_key: ENV.fetch('PUBNUB_SECRET_KEY'),
            ssl: true,
            logger: logger
          )

          __setobj__ @client
        end
      end
    end
  end
end
