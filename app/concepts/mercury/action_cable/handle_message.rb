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

      def handle!(_options)
        # TODO: implement AC message forwarding over HTTP or RabbitMQ
        true
      end
    end
  end
end
