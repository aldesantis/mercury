# frozen_string_literal: true

RSpec.describe Mercury::Transport::Pubnub::Dispatch do
  subject(:result) { described_class.call(notification: notification) }

  before do
    allow(Mercury::Transport::Pubnub::Client).to receive(:publish)
  end

  context 'when the recipient is a profile' do
    let(:profile) { create(:profile) }
    let(:notification) { create(:notification, recipient: profile) }

    it 'publishes to the profile channel' do
      expect(Mercury::Transport::Pubnub::Client).to receive(:publish)
        .with(channel: "profiles:#{profile.id}", message: an_instance_of(Hash))
        .once

      result
    end
  end

  context 'when the recipient is a profile group' do
    let(:profile_group) { create(:profile_group) }
    let(:notification) { create(:notification, recipient: profile_group) }

    it 'publishes to the profile group channel' do
      expect(Mercury::Transport::Pubnub::Client).to receive(:publish)
        .with(channel: "profile_groups:#{profile_group.id}", message: an_instance_of(Hash))
        .once

      result
    end
  end

  context 'when notification is for channel' do
    let(:transports) do
      {
        pubnub: {
          channel: channel_name
        }
      }
    end

    let(:notification) do
      create(:notification, recipient: nil, transports: transports)
    end

    let(:channel_name) { 'test_channel' }

    it 'publishes to the channel name' do
      expect(Mercury::Transport::Pubnub::Client).to receive(:publish)
        .with(channel: 'test_channel', message: an_instance_of(Hash))
        .once

      result
    end
  end
end
