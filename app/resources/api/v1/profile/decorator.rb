# frozen_string_literal: true

module API
  module V1
    module Profile
      class Decorator < Pragma::Decorator::Base
        feature Pragma::Decorator::Type
        feature Pragma::Decorator::Timestamp

        property :id
        property :name
        timestamp :created_at
        timestamp :updated_at
      end
    end
  end
end
