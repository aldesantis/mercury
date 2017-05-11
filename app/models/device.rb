# frozen_string_literal: true

class Device < ApplicationRecord
  extend Enumerize

  belongs_to :profile, inverse_of: :devices

  enumerize :type, in: %w[ios]
end
