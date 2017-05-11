# frozen_string_literal: true

module Mercury
  module Transport
    class APN < Base
      step :deliver!

      def deliver!(params:, **)
        params[:notification].recipient.devices.where(type: 'apple').each do |device|
          Rpush::Apns::Notification.create!(
            app: Rpush::Apns::App.find_by_name('ios_app'),
            device_token: device.source['udid'],
            alert: params[:notification].text,
            data: params[:notification].meta
          )
        end
      end
    end
  end
end
