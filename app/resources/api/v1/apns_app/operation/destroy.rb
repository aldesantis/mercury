# frozen_string_literal: true

module API
  module V1
    module ApnsApp
      module Operation
        class Destroy < Pragma::Operation::Destroy
          step :check_dependencies!, before: 'destroy', fail_fast: true

          def check_dependencies!(options)
            return true if options['model'].devices.empty?

            options['result.response'] = Pragma::Operation::Response::BadRequest.new(
              entity: Pragma::Operation::Error.new(
                error_type: :dependent_devices,
                error_message: 'This application has assigned devices.'
              )
            ).decorate_with(Pragma::Decorator::Error)

            false
          end
        end
      end
    end
  end
end
