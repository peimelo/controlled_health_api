require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/heights', type: :request do
  let(:membership) { create :membership }
  let(:user) { membership.user }
  let(:account) { membership.account }
  let(:height) { create :height, account: account }
  let(:height_two) { create :height, account: create(:membership).account }

  let(:valid_attributes) { attributes_for :height, account: account }
  let(:invalid_attributes) { attributes_for :invalid_height, account: account }

  let(:valid_headers) { user.create_new_auth_token.merge!('account' => account.id.to_s) }

  describe 'GET /index' do
    it 'renders a successful response' do
      height
      get api_heights_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders only heights from logged user' do
      height
      height_two

      get api_heights_url, headers: valid_headers, as: :json
      expect(json_response[:heights].size).to eq 1
      expect(json_response[:heights][0][:id]).to eq height.id
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_heights_url, headers: {}, as: :json }
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_height_url(height), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        get api_height_url(height_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        get api_height_url(height), headers: {}, as: :json
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Height' do
        expect do
          post api_heights_url,
               params: { height: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Height, :count).by(1)
      end

      it 'renders a JSON response with the new height' do
        post api_heights_url,
             params: { height: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Height' do
        expect do
          post api_heights_url,
               params: { height: invalid_attributes }, as: :json
        end.to change(Height, :count).by(0)
      end

      it 'renders a JSON response with errors for the new height' do
        post api_heights_url,
             params: { height: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_heights_url,
             params: { height: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :height, value: 197 }

      it 'updates the requested height' do
        patch api_height_url(height),
              params: { height: new_attributes }, headers: valid_headers, as: :json
        height.reload
        expect(height.value).to eq(new_attributes[:value])
      end

      it 'renders a JSON response with the height' do
        patch api_height_url(height),
              params: { height: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the height' do
        patch api_height_url(height),
              params: { height: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        patch api_height_url(height_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_height_url(height),
              params: { height: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested height' do
      height
      expect do
        delete api_height_url(height), headers: valid_headers, as: :json
      end.to change(Height, :count).by(-1)
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        delete api_height_url(height_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete api_height_url(height), headers: {}, as: :json
      end
    end
  end
end
