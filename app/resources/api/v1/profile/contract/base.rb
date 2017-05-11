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
                    unique_name: 'name must be unique',
                    profile_group?: 'must be a valid profile group ID'
                  }
                })
              end

              def profile_group?(value)
                value.is_a?(::ProfileGroup)
              end
            end

            required(:name).filled
            optional(:profile_groups).maybe { each { profile_group? } }

            validate(unique_name: [:name]) do |name|
              scope = if options[:form].model.persisted?
                ::Profile.where('id <> ?', options[:form].model.id)
              else
                ::Profile.all
              end

              !scope.exists?(name: name)
            end
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
