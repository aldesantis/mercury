# frozen_string_literal: true

module Mercury
  module Transport
    module Apns
      class Dispatch < Base
        step :deliver!

        def deliver!(options)
          options['result.deliveries'] = {}
          options['model.apns_app'] = ::ApnsApp.find(
            options['params'][:notification].transports['apns']['apns_app']
          )

          devices_for(options['params'][:notification], options['model.apns_app']).each do |device|
            options['result.deliveries'][device.id] = deliver_to_device(
              device,
              options['params'][:notification],
              options['model.apns_app']
            )
          end

          options['result.deliveries'].values.all?(&:itself)
        end

        private

        def devices_for(notification, apns_app)
          scope = apns_app.devices

          case notification.recipient
          when ::Profile
            scope.where(profile: notification.recipient)
          when ::ProfileGroup
            scope.joins(profile: :profile_groups).where(
              'profile_groups.id = ?',
              notification.recipient_id
            )
          end
        end

        def deliver_to_device(device, notification, apns_app)
          Rpush::Apns::Notification.create!(
            app: apns_app,
            device_token: device.source['token'],
            alert: notification.text,
            data: notification.meta,
            sound: 'alert_notification.aiff'
          )
        end
      end
    end
  end
end
