# frozen_string_literal: true

module API
  module V1
    module Notification
      module Operation
        class Create < Pragma::Operation::Create
          step :deliver!

          def deliver!(options)
            Mercury::Notification::Deliver.call('notification' => options['model'])
          end
        end
      end
    end
  end
end
