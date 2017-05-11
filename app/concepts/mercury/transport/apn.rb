# frozen_string_literal: true

module Mercury
  module Transport
    class APN < Base
      step :deliver!

      def deliver!(options)
        true
      end
    end
  end
end
