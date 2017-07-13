# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_profile

    def connect
      self.current_profile = find_current_profile
    end

    private

    def find_current_profile
      token = find_jwt_from_url_or_headers
      return reject_unauthorized_connection unless token

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

    def find_jwt_from_url_or_headers
      authorization_header = request.authorization.to_s.split(' ')[1]
      protocol_header = request
        .headers[:HTTP_SEC_WEBSOCKET_PROTOCOL]
        .to_s
        .split(',')
        .last
        .to_s.strip

      jwt = nil

      if authorization_header.present?
        jwt = Base64.decode64(authorization_header)
        Rails.logger.debug "Found JWT in Authorization header: #{jwt}"
      elsif protocol_header.present?
        jwt = protocol_header
        Rails.logger.debug "Found JWT in Sec-WebSocket-Protocol header: #{jwt}"
      end

      jwt
    end
  end
end
