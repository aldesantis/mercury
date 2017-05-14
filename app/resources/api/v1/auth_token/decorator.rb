module API
  module V1
    module AuthToken
      class Decorator < Pragma::Decorator::Base
        feature Pragma::Decorator::Type
        feature Pragma::Decorator::Association

        belongs_to :profile, decorator: API::V1::Profile::Decorator
        property :token
      end
    end
  end
end
