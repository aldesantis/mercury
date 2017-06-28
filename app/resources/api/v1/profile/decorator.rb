# frozen_string_literal: true

module API
  module V1
    module Profile
      class Decorator < Pragma::Decorator::Base
        feature Pragma::Decorator::Type
        feature Pragma::Decorator::Timestamp

        property :id
        property :name
        property :profile_groups, exec_context: :decorator
        timestamp :created_at
        timestamp :updated_at

        def profile_groups
          represented.profile_groups.pluck(:id)
        end
      end
    end
  end
end
