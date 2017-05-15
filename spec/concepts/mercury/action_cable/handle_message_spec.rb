# frozen_string_literal: true

RSpec.describe Mercury::ActionCable::HandleMessage do
  subject(:result) do
    described_class.call(
      { data: data },
      { 'current_profile' => current_profile }
    )
  end

  let(:data) { { 'foo' => 'bar' } }
  let(:current_profile) { build_stubbed(:profile) }

  it 'is successful' do
    expect(result).to be_success
  end
end
