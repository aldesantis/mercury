# frozen_string_literal: true

class ProfileGroup < ApplicationRecord
  has_many :memberships, inverse_of: :profile_group, dependent: :destroy
  has_many :profiles, through: :memberships
  has_many :notifications,
    as: :recipient,
    dependent: :restrict_with_exception,
    inverse_of: :recipient
end
