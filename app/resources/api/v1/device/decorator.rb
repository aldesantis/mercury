# frozen_string_literal: true

module API
  module V1
    module Device
      class Decorator < Pragma::Decorator::Base
        feature Pragma::Decorator::Type
        feature Pragma::Decorator::Timestamp
        feature Pragma::Decorator::Association

        property :id
        belongs_to :profile, decorator: API::V1::Profile::Decorator
        property :type
        property :source
        property :created_at
        property :updated_at
      end
    end
  end
end
