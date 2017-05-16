# frozen_string_literal: true

module API
  module V1
    module ApnsApp
      module Operation
        class Destroy < Pragma::Operation::Destroy
          step :update_devices!

          # TODO: This should be asynchronous, as it blocks the execution of the request.
          def update_devices!(model:, **)
            model.devices.find_each do |device|
              device.source['apns_app'] = device.id
              device.save!
            end
          end
        end
      end
    end
  end
end
