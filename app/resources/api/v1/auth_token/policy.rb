# frozen_string_literal: true

module API
  module V1
    module AuthToken
      class Policy < Pragma::Policy::Base
        def create?
          true
        end
      end
    end
  end
end
