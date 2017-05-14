RSpec.describe '/api/v1/auth-tokens' do
  describe 'POST /' do
    subject { -> { post api_v1_auth_tokens_path, auth_token.to_json } }

    let(:profile) { create(:profile) }
    let(:auth_token) { attributes_for(:auth_token).merge(profile: profile.id) }

    it 'responds with 201 Created' do
      subject.call
      expect(last_response.status).to eq(201)
    end

    it 'responds with the new auth token' do
      subject.call
      expect(parsed_response).to match(a_hash_including(auth_token.stringify_keys))
    end

    it 'includes a JWT in the response' do
      subject.call
      expect(parsed_response).to have_key('token')
    end
  end
end
