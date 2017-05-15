# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_profile

    def connect
      self.current_profile = find_current_profile
    end

    private

    def find_current_profile
      authorization = request.authorization.split(' ')[1]
      return reject_unauthorized_connection if authorization.blank?

      token = Base64.decode64(authorization)
      return reject_unauthorized_connection if token.blank?

      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.secrets.secret_key_base,
          true,
          algorithm: 'HS256'
        )
      rescue JWT::DecodeError
        return reject_unauthorized_connection
      end

      Profile.find_by(id: decoded_token[0]['sub']) || reject_unauthorized_connection
    end
  end
end
