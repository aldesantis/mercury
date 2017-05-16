# frozen_string_literal: true

RSpec.describe Mercury::Transport::Apns::Dispatch do
  subject(:result) { described_class.call(notification: notification) }

  context 'when the recipient is a profile' do
    let(:profile) { create(:profile) }
    let!(:device) { create(:device, type: 'apple', profile: profile) }
    let(:notification) { create(:notification, recipient: profile) }

    it 'sends the notification to each iOS device' do
      expect(Rpush::Apns::Notification).to receive(:create!)
        .with(a_hash_including(
          device_token: device.source['token']
        ))
        .once

      result
    end
  end

  context 'when the recipient is a profile group' do
    let(:profile_group) { create(:profile_group) }
    let(:profile) { create(:profile, profile_groups: [profile_group]) }
    let!(:device) { create(:device, type: 'apple', profile: profile) }
    let(:notification) { create(:notification, recipient: profile_group) }

    it 'sends the notification to each iOS device of its profiles' do
      expect(Rpush::Apns::Notification).to receive(:create!)
        .with(a_hash_including(
          device_token: device.source['token']
        ))
        .once

      result
    end
  end
end
