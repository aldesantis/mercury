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

  def save
    true
  end
end
