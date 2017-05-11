# frozen_string_literal: true

RSpec.describe '/api/v1/notifications' do
  describe 'GET /' do
    subject { -> { get api_v1_notifications_path } }

    let!(:notification) { create(:notification) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the notifications>' do
      subject.call
      expect(parsed_response).to match_array([
        a_hash_including('id' => notification.id)
      ])
    end
  end

  describe 'GET /:id' do
    subject { -> { get api_v1_notification_path(notification) } }

    let!(:notification) { create(:notification) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the notification' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        'id' => notification.id
      ))
    end
  end

  describe 'POST /' do
    subject { -> { post api_v1_notifications_path, notification.to_json } }

    let!(:profile) { create(:profile) }
    let(:notification) do
      attributes_for(:notification).merge(
        recipient_type: 'profile',
        recipient_id: profile.id
      )
    end

    it 'responds with 201 Created' do
      subject.call
      expect(last_response.status).to eq(201)
    end

    it 'creates a new notification' do
      expect(subject).to change(Notification, :count).by(1)
    end

    it 'responds with the new notification' do
      subject.call
      expect(parsed_response).to match(a_hash_including(notification.stringify_keys))
    end

    context 'when passing invalid meta' do
      let(:notification) do
        attributes_for(:notification).merge(
          recipient_type: 'profile',
          recipient_id: profile.id,
          meta: 'foo'
        )
      end

      it 'responds with 422 Unprocessable Entity' do
        subject.call
        expect(last_response.status).to eq(422)
      end

      it 'does not create a new notification' do
        expect(subject).not_to change(Notification, :count)
      end

      it 'responds with the validation error' do
        subject.call
        expect(parsed_response['meta']['errors']['meta']).to include('must be a hash')
      end
    end

    context 'when passing an invalid recipient ID' do
      let(:notification) do
        attributes_for(:notification).merge(
          recipient_type: 'profile',
          recipient_id: 'foo'
        )
      end

      it 'responds with 422 Unprocessable Entity' do
        subject.call
        expect(last_response.status).to eq(422)
      end

      it 'does not create a new notification' do
        expect(subject).not_to change(Notification, :count)
      end

      it 'responds with the validation error' do
        subject.call
        expect(parsed_response['meta']['errors']['recipient_id']).to include(
          'must be a valid recipient ID'
        )
      end
    end
  end
end
