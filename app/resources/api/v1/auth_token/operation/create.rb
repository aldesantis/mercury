# frozen_string_literal: true

module API
  module V1
    module AuthToken
      module Operation
        class Create < Pragma::Operation::Create
          step :grant_pubnub_access!

          def grant_pubnub_access!(model:, **)
            channels = ["profiles:#{model.profile.id}"]
            channels += model.profile.profile_groups.map do |profile_group|
              "profile_groups:#{profile_group.id}"
            end

            Mercury::Transport::Pubnub::Client.grant(
              channels: channels,
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
