# frozen_string_literal: true

module Mercury
  module Transport
    class APN < Base
      step :deliver!

      def deliver!(_options)
        true
      end
    end
  end
end
