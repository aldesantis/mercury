# frozen_string_literal: true

module Mercury
  module Ably
    class Processor
      class << self
        def call
          EventMachine.run do
            client = Ably.realtime

            client.connection.connect do
              log 'event=connected'
            end

            client.connection.on do |state_change|
              log <<~MSG
                event=state_changed
                prev_state=#{state_change.previous}
                new_state=#{state_change.current}
              MSG
            end

            ENV.fetch('ABLY_CHANNELS').split(',').each do |channel_name|
              channel = client.channels.get(channel_name)
              channel.attach do
                log "event=attached channel=#{channel_name}"
              end

              channel.subscribe do |message|
                log <<~MSG
                  event=message_received
                  client_id=#{message.client_id}
                  message_name=#{message.name}
                  message_data=#{message.data.inspect}
                MSG

                profile = Profile.find_by(id: message.client_id)

                if profile
                  Mercury::Transport::ActionCable::Read.call(
                    { message_name: message.name, data: message.data },
                    { 'current_profile' => profile }
                  )
                else
                  log "event=message_discarded profile_id=#{message.client_id}"
                end
              end
            end
          end
        end

        private

        def log(message)
          Rails.logger.debug "[Ably] #{message.delete("\n").strip}"
        end
      end
    end
  end
end
