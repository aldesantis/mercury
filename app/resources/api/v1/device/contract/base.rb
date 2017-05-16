# frozen_string_literal: true

module API
  module V1
    module Device
      module Contract
        class Base < Pragma::Contract::Base
          property :profile
          property :type
          property :source

          validation do
            configure do
              def self.messages
                super.merge(en: {
                  errors: {
                    apns_app?: 'must be a valid APNS app ID'
                  }
                })
              end

              def apns_app?(value)
                ::ApnsApp.exists?(id: value)
              end
            end

            required(:profile).filled
            required(:type).filled(included_in?: ::Device.type.values.map(&:to_s))
            required(:source).schema do
              required(:token).filled(format?: /\A(([a-z0-9]{8})\s){7}([a-z0-9]{8})\z/)
              required(:apns_app).filled(:apns_app?)
            end
          end

          def profile=(val)
            super ::Profile.find_by(id: val)
          end
        end
      end
    end
  end
end
