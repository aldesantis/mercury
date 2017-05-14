# frozen_string_literal: true

RSpec.describe Mercury::Transport::ActionCable do
  subject(:result) { described_class.call(notification: notification) }

  context 'when the recipient is a profile' do
    let(:profile) { create(:profile) }
    let(:notification) { create(:notification, recipient: profile) }

    it 'broadcasts to the ProfilesChannel' do
      expect(ProfilesChannel).to receive(:broadcast_to)
        .with(profile, an_instance_of(Hash))
        .once

      result
    end
  end

  context 'when the recipient is a profile group' do
    let(:profile_group) { create(:profile_group) }
    let(:notification) { create(:notification, recipient: profile_group) }

    it 'broadcasts to the ProfileGroupsChannel' do
      expect(ProfileGroupsChannel).to receive(:broadcast_to)
        .with(profile_group, an_instance_of(Hash))
        .once

      result
    end
  end
end
