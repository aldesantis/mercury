# frozen_string_literal: true

RSpec.describe '/api/v1/profiles' do
  describe 'GET /' do
    subject { -> { get api_v1_profiles_path } }

    let!(:profile) { create(:profile) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the profiles' do
      subject.call
      expect(parsed_response['data']).to match_array([
        a_hash_including('id' => profile.id)
      ])
    end
  end

  describe 'GET /:id' do
    subject { -> { get api_v1_profile_path(profile) } }

    let!(:profile) { create(:profile) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'responds with the profile' do
      subject.call
      expect(parsed_response).to match(a_hash_including(
        'id' => profile.id
      ))
    end
  end

  describe 'POST /' do
    subject { -> { post api_v1_profiles_path, profile.to_json } }

    let(:profile) { attributes_for(:profile) }

    it 'responds with 201 Created' do
      subject.call
      expect(last_response.status).to eq(201)
    end

    it 'creates a new profile' do
      expect(subject).to change(Profile, :count).by(1)
    end

    it 'responds with the new profile' do
      subject.call
      expect(parsed_response).to match(a_hash_including(profile.stringify_keys))
    end
  end

  describe 'PATCH /:id' do
    subject do
      proc do
        patch api_v1_profile_path(profile), new_profile.to_json
        profile.reload
      end
    end

    let!(:profile) { create(:profile) }
    let(:new_profile) { attributes_for(:profile) }

    it 'responds with 200 OK' do
      subject.call
      expect(last_response.status).to eq(200)
    end

    it 'updates the profile' do
      subject.call
      expect(profile.as_json).to match(a_hash_including(new_profile.stringify_keys))
    end

    it 'responds with the updated profile' do
      subject.call
      expect(parsed_response).to match(a_hash_including(new_profile.stringify_keys))
    end

    context 'when an existing name is used' do
      let!(:existing_profile) { create(:profile) }
      let(:new_profile) { attributes_for(:profile, name: existing_profile.name) }

      it 'responds with 422 Unprocessable Entity' do
        subject.call
        expect(last_response.status).to eq(422)
      end

      it 'does not update the profile' do
        expect(subject).not_to change(profile, :name)
      end

      it 'responds with the validation error' do
        subject.call
        expect(parsed_response['meta']['errors']['name']).to include('must be unique')
      end
    end

    context 'when valid profile groups are passed' do
      let!(:profile_group) { create(:profile_group) }

      let(:new_profile) do
        { profile_groups: [profile_group.id] }
      end

      it 'responds with 200 OK' do
        subject.call
        expect(last_response.status).to eq(200)
      end

      it 'updates the profile' do
        subject.call
        expect(profile.profile_groups.pluck(:id)).to eq(new_profile[:profile_groups])
      end

      it 'responds with the updated profile' do
        subject.call
        expect(parsed_response).to match(a_hash_including(new_profile.stringify_keys))
      end
    end

    context 'when invalid profile groups are passed' do
      let!(:profile_group) { create(:profile_group) }

      let(:new_profile) do
        { profile_groups: [profile_group.id, 'blabla'] }
      end

      it 'responds with 422 Unprocessable Entity' do
        subject.call
        expect(last_response.status).to eq(422)
      end

      it 'does not update the profile' do
        expect(subject).not_to change(profile.profile_groups, :count)
      end

      it 'responds with the validation error' do
        subject.call
        expect(parsed_response['meta']['errors']['profile_groups'].first).to match_array([
          1,
          ['must be a valid profile group ID']
        ])
      end
    end
  end

  describe 'DELETE /:id' do
    subject { -> { delete api_v1_profile_path(profile) } }

    let!(:profile) { create(:profile) }

    it 'deletes the profile' do
      expect(subject).to change(Profile, :count).by(-1)
    end

    it 'responds with 204 No Content' do
      subject.call
      expect(last_response.status).to eq(204)
    end
  end
end
