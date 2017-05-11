# frozen_string_literal: true

module Mercury
  module Notification
    class Deliver < Trailblazer::Operation
      TRANSPORTS = %w[ios].freeze

      step :deliver!

      def deliver!(_options)
        true
      end
    end
  end
end
