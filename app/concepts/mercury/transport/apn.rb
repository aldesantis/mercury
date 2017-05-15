# frozen_string_literal: true

module Mercury
  module Transport
    class APN < Base
      step :deliver!

      def deliver!(params:, **)
        devices_for(params[:notification]).each do |device|
          Rpush::Apns::Notification.create!(
            app: Rpush::Apns::App.find_by(name: 'ios_app'),
            device_token: device.source['udid'],
            alert: params[:notification].text,
            data: params[:notification].meta
          )
        end
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
    end
  end
end