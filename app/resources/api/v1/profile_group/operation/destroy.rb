# frozen_string_literal: true

module API
  module V1
    module ProfileGroup
      module Operation
        class Destroy < Pragma::Operation::Destroy
          step :check_dependencies!, before: :destroy!, fail_fast: true

          def check_dependencies!(options)
            return true if options['model'].profiles.empty?

            options['result.response'] = Pragma::Operation::Response::BadRequest.new(
              entity: Pragma::Operation::Error.new(
                error_type: :dependent_profiles,
                error_message: 'This profile group has assigned profiles.'
              )
            ).decorate_with(Pragma::Decorator::Error)

            false
          end
        end
      end
    end
  end
end
