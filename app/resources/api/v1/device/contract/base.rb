# frozen_string_literal: true

module API
  module V1
    module Device
      module Contract
        class Base < Pragma::Contract::Base
          property :profile
          property :type
          property :source

          validation do
            required(:profile).filled
            required(:type).filled(included_in?: ::Device.type.values.map(&:to_s))
            required(:source).schema do
              required(:udid).filled
            end
          end

          def profile=(val)
            super ::Profile.find_by(id: val)
          end
        end
      end
    end
  end
end
