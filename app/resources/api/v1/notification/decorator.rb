module API
  module V1
    module Notification
      class Decorator < Pragma::Decorator::Base
        feature Pragma::Decorator::Type
        feature Pragma::Decorator::Timestamp

        property :id
        property :recipient_type, exec_context: :decorator
        property :recipient_id
        property :text
        property :meta
        timestamp :created_at
        timestamp :updated_at

        def recipient_type
          represented.recipient_type.underscore
        end
      end
    end
  end
end
