# frozen_string_literal: true

module Mercury
  module Transport
    module Ably
      class Read < Trailblazer::Operation
        extend Contract::DSL

        contract 'params', (Dry::Validation.Schema do
          required(:message_name).filled(:str?)
          required(:data).schema do
          end
        end)

        step Contract::Validate(name: 'params')
        step :handle!

        def handle!(params:, current_profile:, **)
          BunnyClient.publish(
            transport: :ably,
            message_name: params[:message_name],
            data: params[:data],
            profile: current_profile.id
          )
        end
      end
    end
  end
end
