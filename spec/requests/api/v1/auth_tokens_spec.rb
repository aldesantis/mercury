# frozen_string_literal: true

RSpec.describe '/api/v1/auth-tokens' do
  describe 'POST /' do
    subject { -> { post api_v1_auth_tokens_path, auth_token.to_json } }

    let(:profile) { create(:profile) }
    let(:auth_token) do
      attributes_for(:auth_token, transport: transport).merge(profile: profile.id)
    end

    %w[ably action_cable].each do |transport|
      context "with the #{transport} transport" do
        let(:transport) { transport }

        it 'responds with 201 Created' do
          subject.call
          expect(last_response.status).to eq(201)
        end

        it 'responds with the new auth token' do
          subject.call
          expect(parsed_response).to match(a_hash_including(auth_token.stringify_keys))
        end

        it 'includes a token in the response' do
          subject.call
          expect(parsed_response).to have_key('token')
        end
      end
    end
  end
end
