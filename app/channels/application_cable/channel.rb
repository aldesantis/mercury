# frozen_string_literal: true

module ApplicationCable
  class Channel < ActionCable::Channel::Base
    protected

    def handle_message(data)
      Mercury::Transport::ActionCable::Read.call(
        { data: data },
        { 'current_profile' => current_profile }
      )
    end
  end
end
