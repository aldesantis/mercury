# frozen_string_literal: true

module API
  module V1
    module ProfileGroup
      module Contract
        class Base < Pragma::Contract::Base
          property :name

          validation do
            configure do
              def self.messages
                super.merge(en: {
                  errors: {
                    unique_name?: 'must be unique'
                  }
                })
              end

              option :form

              predicates API::V1::Common::Contract::Predicates

              def unique_name?(value)
                predicates[:unique?].call(form, ::ProfileGroup, :name, value)
              end
            end

            required(:name).filled { unique_name? }
          end
        end
      end
    end
  end
end
