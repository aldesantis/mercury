# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :profile, inverse_of: :memberships
  belongs_to :profile_group, inverse_of: :memberships
end
