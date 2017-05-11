# frozen_string_literal: true

RSpec.describe Membership do
  subject { build_stubbed(:membership) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
