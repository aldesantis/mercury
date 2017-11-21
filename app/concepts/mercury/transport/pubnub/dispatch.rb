# frozen_string_literal: true

module Mercury
  module Transport
    module Pubnub
      class Dispatch < Base
        step :deliver!

        def deliver!(params:, **)
          return false unless channel_for(params[:notification])
          Client.publish(
            channel: channel_for(params[:notification]),
            message: {
              text: params[:notification].text,
              meta: params[:notification].meta
            }
          ) do |envelope|
            Rails.logger.debug envelope.status
          end
        end

        private

        def channel_for(notification)
          case notification.recipient
          when ::Profile
            "profiles:#{notification.recipient.id}"
          when ::ProfileGroup
            "profile_groups:#{notification.recipient.id}"
          when nil
            notification.transports.with_indifferent_access.dig('pubnub', 'channel')
          end
        end
      end
    end
  end
end
