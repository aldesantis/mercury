# frozen_string_literal: true

module Mercury
  module Ably
    class << self
      def rest
        @rest ||= ::Ably::Rest.new(key: ENV.fetch('ABLY_API_KEY'))
      end

      def realtime
        @realtime ||= ::Ably::Realtime.new(key: ENV.fetch('ABLY_API_KEY'))
      end
    end
  end
end
