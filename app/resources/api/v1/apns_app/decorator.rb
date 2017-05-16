# frozen_string_literal: true

module API
  module V1
    module ApnsApp
      class Decorator < Pragma::Decorator::Base
        feature Pragma::Decorator::Type
        feature Pragma::Decorator::Timestamp

        property :id
        property :name
        property :environment
        timestamp :created_at
        timestamp :updated_at

        def type
          'apns_app'
        end
      end
    end
  end
end
