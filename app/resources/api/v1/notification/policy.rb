module API
  module V1
    module Notification
      class Policy < Pragma::Policy::Base
        class Scope < Pragma::Policy::Base::Scope
          def resolve
            scope
          end
        end

        def show?
          true
        end

        def create?
          true
        end
      end
    end
  end
end
