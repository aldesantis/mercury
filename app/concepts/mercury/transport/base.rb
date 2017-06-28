# frozen_string_literal: true

module Mercury
  module Transport
    class Base < Trailblazer::Operation
      extend Contract::DSL

      contract 'params', (Dry::Validation.Schema do
        required(:notification).filled
      end)

      step Contract::Validate(name: 'params')
    end
  end
end
