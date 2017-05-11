# frozen_string_literal: true

class Device < ApplicationRecord
  extend Enumerize

  self.inheritance_column = false

  belongs_to :profile, inverse_of: :devices

  enumerize :type, in: %w[ios]
end
