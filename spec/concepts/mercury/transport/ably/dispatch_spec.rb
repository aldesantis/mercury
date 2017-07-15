# frozen_string_literal: true

RSpec.describe Mercury::Transport::Ably::Dispatch do
  subject(:result) do
    described_class.call({
      notification: notification
    }, {
      'ably' => ably
    })
  end

  let(:ably) { instance_double('Ably::Rest::Client') }
  let(:ably_channel) { instance_double('Ably::Channel') }

  before do
    allow(ably).to receive(:channel)
      .with(channel_name)
      .and_return(ably_channel)
  end

  context 'when the recipient is a profile' do
    let(:profile) { create(:profile) }
    let(:notification) { create(:notification, recipient: profile) }

    let(:channel_name) { "profiles:#{profile.id}" }

    it 'publishes to the profile' do
      expect(ably_channel).to receive(:publish)
        .with('message', text: notification.text, meta: notification.meta)
        .once

      result
    end
  end

  context 'when the recipient is a profile group' do
    let(:profile_group) { create(:profile_group) }
    let(:notification) { create(:notification, recipient: profile_group) }

    let(:channel_name) { "profile_groups:#{profile_group.id}" }

    it 'publishes to the profile group' do
      expect(ably_channel).to receive(:publish)
        .with('message', text: notification.text, meta: notification.meta)
        .once

      result
    end
  end
end
