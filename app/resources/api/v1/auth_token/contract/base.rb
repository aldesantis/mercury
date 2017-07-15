# frozen_string_literal: true

module API
  module V1
    module AuthToken
      module Contract
        class Base < Pragma::Contract::Base
          property :transport
          property :profile

          validation do
            required(:transport).filled(included_in?: %w[action_cable ably])
            required(:profile).filled
          end

          def profile=(val)
            super ::Profile.find_by(id: val)
          end
        end
      end
    end
  end
end
