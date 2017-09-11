# frozen_string_literal: true

class AuthToken
  attr_accessor :profile

  def token
    JWT.encode(
      { 'sub' => profile.id },
      Rails.application.secrets.secret_key_base,
      'HS256'
    )
  end

  def pubnub_channels
    ["profiles:#{profile.id}"].tap do |channels|
      profile.profile_groups.each do |profile_group|
        channels << "profile_groups:#{profile_group.id}"
      end
    end
  end

  def save
    true
  end
end
