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
        BunnyClient.publish(
          data: params[:data],
          profile: current_profile.id
        )
      end
    end
  end
end
