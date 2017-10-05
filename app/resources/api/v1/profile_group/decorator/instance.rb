# frozen_string_literal: true

module API
  module V1
    module ProfileGroup
      module Decorator
        class Instance < Pragma::Decorator::Base
          feature Pragma::Decorator::Type

          property :id
          property :name
        end
      end
    end
  end
end
