# frozen_string_literal: true

module Mercury
  module Transport
    module Ably
      class Dispatch < Base
        step :initialize_ably!
        step :deliver!

        def initialize_ably!(options)
          options['ably'] ||= ::Mercury::Ably.rest
        end

        def deliver!(params:, ably:, **)
          ably.channel(channel_for(params[:notification])).publish(
            'message',
            text: params[:notification].text,
            meta: params[:notification].meta
          )
        end

        private

        def channel_for(notification)
          case notification.recipient
          when ::Profile
            "profiles:#{notification.recipient_id}"
          when ::ProfileGroup
            "profile_groups:#{notification.recipient_id}"
          else
            fail(
              ArgumentError,
              "Cannot determine Ably channel for #{notification.recipient.inspect}"
            )
          end
        end
      end
    end
  end
end
