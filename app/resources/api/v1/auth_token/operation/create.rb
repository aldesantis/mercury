# frozen_string_literal: true

module API
  module V1
    module AuthToken
      module Operation
        class Create < Pragma::Operation::Create
          step :grant_pubnub_access!

          def grant_pubnub_access!(model:, **)
            return if ENV['DISABLE_PUBNUB'] == 'true'
            Mercury::Transport::Pubnub::Client.grant(
              channels: model.pubnub_channels,
              read: true,
              write: false,
              ttl: 0,
              authKeys: [model.token]
            )
          end
        end
      end
    end
  end
end
