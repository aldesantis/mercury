# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Knock::Authenticable

    identified_by :current_profile

    def connect
      self.current_profile = find_current_profile
    end

    private

    def find_current_profile
      authorization = request.headers['Authorization'].split(' ')[1]
      return reject_unauthorized_connection unless authorization.present?

      token = Base64.decode64(authorization).split(' ')[1].split(':')[1]
      return reject_unauthorized_connection unless token.present?

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
