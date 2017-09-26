# frozen_string_literal: true

module API
  module V1
    module AuthToken
      module Decorator
        class Instance < Pragma::Decorator::Base
          feature Pragma::Decorator::Type
          feature Pragma::Decorator::Association

          belongs_to :profile, decorator: API::V1::Profile::Decorator
          property :token
          property :pubnub_channels
        end
      end
    end
  end
end
