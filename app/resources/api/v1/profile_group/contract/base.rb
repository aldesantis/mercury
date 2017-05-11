# frozen_string_literal: true

module API
  module V1
    module ProfileGroup
      module Contract
        class Base < Pragma::Contract::Base
          property :name

          validation do
            configure do
              def self.messages
                super.merge(en: {
                  errors: {
                    unique_name: 'name is not unique'
                  }
                })
              end
            end

            required(:name).filled

            validate(unique_name: [:name]) do |name|
              scope = if options[:form].model.persisted?
                ::ProfileGroup.where('id <> ?', options[:form].model.id)
              else
                ::ProfileGroup.all
              end

              !scope.exists?(name: name)
            end
          end
        end
      end
    end
  end
end
