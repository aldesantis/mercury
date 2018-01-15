# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :memberships, inverse_of: :profile, dependent: :destroy
  has_many :profile_groups, through: :memberships, dependent: :destroy
  has_many :notifications,
    as: :recipient,
    dependent: :restrict_with_exception,
    inverse_of: :recipient
  has_many :devices, inverse_of: :profile, dependent: :destroy
end
