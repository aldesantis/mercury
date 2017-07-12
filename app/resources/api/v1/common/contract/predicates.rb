# frozen_string_literal: true

module API
  module V1
    module Common
      module Contract
        module Predicates
          include Dry::Logic::Predicates

          predicate :instance_of? do |klass, value|
            value.is_a?(klass)
          end

          predicate :unique? do |form, klass, column, value|
            scope = if form.model.persisted?
              klass.where('id <> ?', form.model.id)
            else
              klass.all
            end

            !scope.exists?(column => value)
          end

          predicate :apns_app? do |value|
            ::ApnsApp.exists?(id: value)
          end
        end
      end
    end
  end
end
