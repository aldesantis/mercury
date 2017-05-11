# frozen_string_literal: true

RSpec.describe Notification do
  subject { build_stubbed(:notification) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
