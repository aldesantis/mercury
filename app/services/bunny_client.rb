# frozen_string_literal: true

class BunnyClient
  class << self
    def publish(payload)
      exchange.publish(
        (payload.is_a?(String) ? payload : payload.to_json),
        routing_key: queue.name
      )
    end

    private

    def connection
      @connection ||= Bunny.new(ENV.fetch('RABBITMQ_URL')).tap(&:start)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def queue
      @queue ||= channel.queue('b911.messages', auto_delete: true)
    end

    def exchange
      @exchange ||= channel.default_exchange
    end
  end
end
