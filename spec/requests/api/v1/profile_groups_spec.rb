# frozen_string_literal: true

RSpec.describe '/api/v1/profile-groups' do
  describe 'GET /' do
    subject { -> { get api_v1_profile_groups_path } }

    let!(:profile_group) { create(:profile_group) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the profile groups>' do
      subject.call
      expect(parsed_response).to match_array([
        a_hash_including('id' => profile_group.id)
      ])
    end
  end

  describe 'GET /:id' do
    subject { -> { get api_v1_profile_group_path(profile_group) } }

    let!(:profile_group) { create(:profile_group) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the profile group' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        'id' => profile_group.id
      ))
    end
  end

  describe 'POST /' do
    subject { -> { post api_v1_profile_groups_path, profile_group.to_json } }

    let(:profile_group) { attributes_for(:profile_group) }

    it 'responds with 201 Created' do
      subject.call
      expect(last_response.status).to eq(201)
    end

    it 'creates a new profile group' do
      expect(subject).to change(ProfileGroup, :count).by(1)
    end

    it 'responds with the new profile group' do
      subject.call
      expect(parsed_response).to match(a_hash_including(profile_group.stringify_keys))
    end
  end

  describe 'PATCH /:id' do
    subject do
      proc do
        patch api_v1_profile_group_path(profile_group), new_profile_group.to_json
        profile_group.reload
      end
    end

    let!(:profile_group) { create(:profile_group) }
    let(:new_profile_group) { attributes_for(:profile_group) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'updates the profile group' do
      subject.call
      expect(profile_group.as_json).to match(a_hash_including(new_profile_group.stringify_keys))
    end

    it 'responds with the updated profile group' do
      subject.call
      expect(parsed_response).to match(a_hash_including(new_profile_group.stringify_keys))
    end

    context 'when an existing name is used' do
      let!(:existing_profile_group) { create(:profile_group) }
      let(:new_profile_group) { attributes_for(:profile_group, name: existing_profile_group.name) }

      it 'responds with 422 Unprocessable Entity' do
        subject.call
        expect(last_response.status).to eq(422)
      end

      it 'does not update the profile group' do
        expect(subject).not_to change(profile_group, :name)
      end

      it 'responds with the validation error' do
        subject.call
        expect(parsed_response['meta']['errors']['name']).to include('must be unique')
      end
    end
  end

  describe 'DELETE /:id' do
    subject { -> { delete api_v1_profile_group_path(profile_group) } }

    let!(:profile_group) { create(:profile_group) }

    it 'deletes the profile group' do
      expect(subject).to change(ProfileGroup, :count).by(-1)
    end

    it 'responds with 204 No Content' do
      subject.call
      expect(last_response.status).to eq(204)
    end

    context 'when the profile group has dependent profiles' do
      before { create(:membership, profile_group: profile_group) }

      it 'responds with 400 Bad Request' do
        subject.call
        expect(last_response.status).to eq(400)
      end

      it 'responds with an error message' do
        subject.call
        expect(parsed_response['error_type']).to eq('dependent_profiles')
      end
    end
  end
end
