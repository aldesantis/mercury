# frozen_string_literal: true

module API
  module V1
    module Profile
      module Contract
        class Base < Pragma::Contract::Base
          property :name
          property :profile_groups, populator: :populate_profile_groups

          validation do
            configure do
              def self.messages
                super.merge(en: {
                  errors: {
                    unique_name?: 'must be unique',
                    profile_group?: 'must be a valid profile group ID'
                  }
                })
              end

              option :form

              predicates API::V1::Common::Contract::Predicates

              def unique_name?(value)
                predicates[:unique?].call(form, ::Profile, :name, value)
              end

              def profile_group?(value)
                predicates[:instance_of?].call(::ProfileGroup, value)
              end
            end

            required(:name).filled { unique_name? }
            optional(:profile_groups).maybe { each { profile_group? } }
          end

          def initialize(*)
            super
            self.profile_groups = profile_groups.to_a
          end

          def populate_profile_groups(fragment:, **)
            self.profile_groups = fragment.map { |id| ::ProfileGroup.find_by(id: id) }
          end
        end
      end
    end
  end
end
