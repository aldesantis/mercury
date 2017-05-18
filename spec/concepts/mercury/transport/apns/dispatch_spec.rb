# frozen_string_literal: true

RSpec.describe Mercury::Transport::Apns::Dispatch do
  subject(:result) { described_class.call(notification: notification) }

  context 'when the recipient is a profile' do
    let(:profile) { create(:profile) }
    let(:apns_app) { create(:apns_app) }
    let!(:device) { create(:device, type: 'apple', profile: profile, apns_app: apns_app) }
    let(:notification) { create(:notification, :apns, recipient: profile, apns_app: apns_app) }

    before { create(:device, type: 'apple', profile: profile) }

    it 'sends the notification to each iOS device assigned to that APNS app' do
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
    let(:apns_app) { create(:apns_app) }
    let!(:device) { create(:device, type: 'apple', profile: profile, apns_app: apns_app) }
    let(:notification) do
      create(:notification, :apns, recipient: profile_group, apns_app: apns_app)
    end

    before { create(:device, type: 'apple', profile: profile) }

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
