# frozen_string_literal: true

RSpec.describe '/api/v1/devices' do
  describe 'GET /' do
    subject { -> { get api_v1_devices_path } }

    let!(:device) { create(:device) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the devices' do
      subject.call
      expect(parsed_response['data']).to match_array([
        a_hash_including('id' => device.id)
      ])
    end
  end

  describe 'GET /:id' do
    subject { -> { get api_v1_device_path(device) } }

    let!(:device) { create(:device) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the device' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        'id' => device.id
      ))
    end
  end

  describe 'POST /' do
    subject { -> { post api_v1_devices_path, device.to_json } }

    let!(:profile) { create(:profile) }

    let(:device) do
      attributes_for(:device).merge(profile: profile.id)
    end

    it 'responds with 201 Created' do
      subject.call
      expect(last_response.status).to eq(201)
    end

    it 'creates a new device' do
      expect(subject).to change(Device, :count).by(1)
    end

    it 'responds with the new device' do
      subject.call
      expect(parsed_response).to match(a_hash_including(device.stringify_keys))
    end

    context 'when an invalid apns_app is passed' do
      let(:device) do
        attributes_for(:device).merge(profile: profile.id).tap do |d|
          d[:source]['apns_app'] = 'dummy'
        end
      end

      it 'responds with 422 Unprocessable Entity' do
        subject.call
        expect(last_response.status).to eq(422)
      end

      it 'does not create a new device' do
        expect(subject).not_to change(Device, :count)
      end

      it 'responds with the error' do
        subject.call
        expect(parsed_response['meta']['errors']['source'].first).to eq(
          ['apns_app', ['must be a valid APNS app ID']]
        )
      end
    end
  end

  describe 'PATCH /:id' do
    subject do
      proc do
        patch api_v1_device_path(device), new_device.to_json
        device.reload
      end
    end

    let!(:device) { create(:device) }
    let(:new_device) { attributes_for(:device) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'updates the device' do
      subject.call
      expect(device.as_json).to match(a_hash_including(new_device.stringify_keys))
    end

    it 'responds with the updated device' do
      subject.call
      expect(parsed_response).to match(a_hash_including(new_device.stringify_keys))
    end
  end

  describe 'DELETE /:id' do
    subject { -> { delete api_v1_device_path(device) } }

    let!(:device) { create(:device) }

    it 'deletes the device' do
      expect(subject).to change(Device, :count).by(-1)
    end

    it 'responds with 204 No Content' do
      subject.call
      expect(last_response.status).to eq(204)
    end
  end
end
