# frozen_string_literal: true

class BunnyClient
  class << self
    def connection
      @client ||= Bunny.new.tap(&:start)
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
