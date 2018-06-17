# frozen_string_literal: true

class HealthController < ApplicationController
  def show
    head :no_content
  end
end
