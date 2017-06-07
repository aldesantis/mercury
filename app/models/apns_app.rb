# frozen_string_literal: true

class ApnsApp < Rpush::Apns::App
  self.inheritance_column = false

  default_scope -> { where type: 'Rpush::Client::ActiveRecord::Apns::App' }

  def devices
    ::Device.where(type: 'apple').where("CAST(source->>'apns_app' AS integer) = ?", id)
  end
end
