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
      protocol_header = request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL].to_s.split(',').last

      puts "Authorization header: #{request.authorization.to_s.inspect}"
      puts "Sec-WebSocket-Protocol header: #{request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL].to_s.inspect}"

      if authorization_header.present?
        return Base64.decode64(authorization_header)
      elsif protocol_header.present?
        return protocol_header
      end

      reject_unauthorized_connection
    end
  end
end
