# frozen_string_literal: true

class AuthToken
  attr_accessor :profile, :transport

  def token
    case transport.to_sym
    when :action_cable
      JWT.encode(
        { 'sub' => profile.id },
        Rails.application.secrets.secret_key_base,
        'HS256'
      )
    when :ably
      Ably::Rest.new(key: ENV.fetch('ABLY_API_KEY')).auth.create_token_request(
        ttl: 3600,
        client_id: profile.id
      ).as_json
    end
  end

  def save
    true
  end
end
