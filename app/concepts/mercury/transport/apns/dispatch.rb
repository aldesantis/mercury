# frozen_string_literal: true

module Mercury
  module Transport
    module Apns
      class Dispatch < Base
        step :deliver!

        def deliver!(options)
          options['result.deliveries'] = {}

          devices_for(options['params'][:notification]).each do |device|
            options['result.deliveries'][device.id] = deliver_to_device(
              device,
              options['params'][:notification]
            )
          end

          options['result.deliveries'].values.all?(&:itself)
        end

        private

        def devices_for(notification)
          case notification.recipient
          when ::Profile
            notification.recipient.devices
          when ::ProfileGroup
            ::Device.joins(profile: :profile_groups).where(
              'profile_groups.id = ?',
              notification.recipient_id
            )
          end.where(type: 'apple')
        end

        def deliver_to_device(device, notification)
          app = ApnsApp.find_by(id: device.source['apns_app'])
          return false unless app

          Rpush::Apns::Notification.create!(
            app: app,
            device_token: device.source['udid'],
            alert: notification.text,
            data: notification.meta
          )
        end
      end
    end
  end
end
