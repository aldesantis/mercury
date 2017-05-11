# frozen_string_literal: true

module API
  module V1
    module Notification
      module Contract
        class Base < Pragma::Contract::Base
          property :recipient_type
          property :recipient_id
          property :text
          property :meta

          validation do
            configure do
              def self.messages
                super.merge(en: {
                  errors: {
                    recipient_id: 'must be a valid recipient ID'
                  }
                })
              end

              predicates API::V1::Common::Contract::Predicates
            end

            required(:recipient_type).filled(included_in?: %w[Profile ProfileGroup])
            required(:recipient_id).filled
            required(:text).filled
            optional(:meta).maybe(:hash?)

            validate(recipient_id: %i[
              recipient_type
              recipient_id
            ]) do |recipient_type, recipient_id|
              "::#{recipient_type}".constantize.exists?(id: recipient_id)
            end
          end

          def recipient_type=(val)
            super val.camelcase
          end
        end
      end
    end
  end
end
