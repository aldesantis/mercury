# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  serialize :meta, Hash
end
