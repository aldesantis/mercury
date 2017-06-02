# frozen_string_literal: true

module Mercury
  module Transport
    module ActionCable
      class Dispatch < Base
        step :deliver!

        def deliver!(params:, **)
          channel_for(params[:notification]).broadcast_to(
            params[:notification].recipient,
            text: params[:notification].text,
            meta: params[:notification].meta
          )
        end

        private

        def channel_for(notification)
          case notification.recipient
          when ::Profile
            ProfilesChannel
          when ::ProfileGroup
            ProfileGroupsChannel
          end
        end
      end
    end
  end
end
