# frozen_string_literal: true

RSpec.describe Mercury::Transport::Ably::Read do
  subject(:result) do
    described_class.call(
      { message_name: message_name, data: data },
      { 'current_profile' => current_profile }
    )
  end

  let(:message_name) { 'test' }
  let(:data) { { 'foo' => 'bar' } }
  let(:current_profile) { build_stubbed(:profile) }

  before do
    allow(current_profile).to receive(:id).and_return(SecureRandom.uuid)
    allow(BunnyClient).to receive(:publish).and_return(true)
  end

  it 'is successful' do
    expect(result).to be_success
  end

  it 'publishes the message to RabbitMQ' do
    expect(BunnyClient).to receive(:publish)
      .with(a_hash_including(
        transport: :ably,
        message_name: 'test',
        data: data,
        profile: current_profile.id
      ))
      .once
      .and_return(true)

    result
  end
end
