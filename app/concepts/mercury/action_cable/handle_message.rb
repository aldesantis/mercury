# frozen_string_literal: true

module Mercury
  module ActionCable
    class HandleMessage < Trailblazer::Operation
      extend Contract::DSL

      contract 'params', (Dry::Validation.Schema do
        required(:data).schema do
        end
      end)

      step Contract::Validate(name: 'params')
      step :handle!

      def handle!(params:, current_profile:, **)
        BunnyClient.exchange.publish(
          {
            data: params[:data],
            profile: current_profile.id
          }.to_json,
          routing_key: BunnyClient.queue.name
        )
      end
    end
  end
end
