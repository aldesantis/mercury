# frozen_string_literal: true

module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def perform_action(data)
      handle_message(data) unless subscription_rejected?
    end

    protected

    def handle_message(data)
      Mercury::Transport::ActionCable::Read.call(
        { data: data },
        { 'current_profile' => current_profile }
      )
    end
  end
end
