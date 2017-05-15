# frozen_string_literal: true

class ProfileGroupsChannel < ApplicationCable::Channel
  def subscribed
    current_profile.profile_groups.each do |profile_group|
      stream_for profile_group
    end
  end

  def receive(data)
    handle_message(data)
  end
end
