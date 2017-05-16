# frozen_string_literal: true

RSpec.describe '/api/v1/apns-apps' do
  describe 'GET /' do
    subject { -> { get api_v1_apns_apps_path } }

    let!(:apns_app) { create(:apns_app) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the APNS apps' do
      subject.call
      expect(parsed_response).to match_array([
        a_hash_including('id' => apns_app.id)
      ])
    end
  end

  describe 'GET /:id' do
    subject { -> { get api_v1_apns_app_path(apns_app) } }

    let!(:apns_app) { create(:apns_app) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the APNS app' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        'id' => apns_app.id
      ))
    end
  end

  describe 'POST /' do
    subject { -> { post api_v1_apns_apps_path, apns_app.to_json } }

    let(:apns_app) { attributes_for(:apns_app) }

    it 'responds with 201 Created' do
      subject.call
      expect(last_response.status).to eq(201)
    end

    it 'creates a new APNS app' do
      expect(subject).to change(ApnsApp, :count).by(1)
    end

    it 'responds with the new APNS app' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        apns_app.stringify_keys.except('certificate')
      ))
    end
  end

  describe 'PATCH /:id' do
    subject do
      proc do
        patch api_v1_apns_app_path(apns_app), new_apns_app.to_json
        apns_app.reload
      end
    end

    let!(:apns_app) { create(:apns_app) }
    let(:new_apns_app) { attributes_for(:apns_app) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'updates the APNS app' do
      subject.call
      expect(apns_app.as_json).to match(a_hash_including(new_apns_app.stringify_keys))
    end

    it 'responds with the updated APNS app' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        new_apns_app.stringify_keys.except('certificate')
      ))
    end
  end

  describe 'DELETE /:id' do
    subject { -> { delete api_v1_apns_app_path(apns_app) } }

    let!(:apns_app) { create(:apns_app) }

    it 'deletes the APNS app' do
      expect(subject).to change(ApnsApp, :count).by(-1)
    end

    it 'responds with 204 No Content' do
      subject.call
      expect(last_response.status).to eq(204)
    end
  end
end
