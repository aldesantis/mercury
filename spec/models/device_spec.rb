# frozen_string_literal: true

RSpec.describe Device do
  subject { build_stubbed(:device) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
