# frozen_string_literal: true

class Profile < ApplicationRecord
  has_many :memberships, inverse_of: :profile
  has_many :profile_groups, through: :memberships
end
