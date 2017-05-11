# frozen_string_literal: true

class ProfileGroup < ApplicationRecord
  has_many :memberships, inverse_of: :profile_group
  has_many :profiles, through: :memberships
end
