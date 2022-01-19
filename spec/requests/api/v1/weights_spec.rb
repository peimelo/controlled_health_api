require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/weights', type: :request do
  let(:membership) { create :membership }
  let(:user) { membership.user }
  let(:account) { membership.account }
  let(:weight) { create :weight, account: account }
  let(:weight_two) { create :weight, account: create(:membership).account }

  let(:valid_attributes) { attributes_for :weight, account: account }
  let(:invalid_attributes) { attributes_for :invalid_weight, account: account }

  let(:valid_headers) { user.create_new_auth_token.merge!('account' => account.id.to_s) }

  describe 'GET /index' do
    it 'renders a successful response' do
      weight
      get api_weights_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders only weights from logged user' do
      weight
      weight_two

      get api_weights_url, headers: valid_headers, as: :json
      expect(json_response[:weights].size).to eq 1
      expect(json_response[:weights][0][:id]).to eq weight.id
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_weights_url, headers: {}, as: :json }
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_weight_url(weight), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        get api_weight_url(weight_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        get api_weight_url(weight), headers: {}, as: :json
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Weight' do
        expect do
          post api_weights_url,
               params: { weight: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Weight, :count).by(1)
      end

      it 'renders a JSON response with the new weight' do
        post api_weights_url,
             params: { weight: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Weight' do
        expect do
          post api_weights_url,
               params: { weight: invalid_attributes }, as: :json
        end.to change(Weight, :count).by(0)
      end

      it 'renders a JSON response with errors for the new weight' do
        post api_weights_url,
             params: { weight: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_weights_url,
             params: { weight: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :weight, value: 99.98 }

      it 'updates the requested weight' do
        patch api_weight_url(weight),
              params: { weight: new_attributes }, headers: valid_headers, as: :json
        weight.reload
        expect(weight.value).to eq(new_attributes[:value])
      end

      it 'renders a JSON response with the weight' do
        patch api_weight_url(weight),
              params: { weight: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the weight' do
        patch api_weight_url(weight),
              params: { weight: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        patch api_weight_url(weight_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_weight_url(weight),
              params: { weight: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested weight' do
      weight
      expect do
        delete api_weight_url(weight), headers: valid_headers, as: :json
      end.to change(Weight, :count).by(-1)
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        delete api_weight_url(weight_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete api_weight_url(weight), headers: {}, as: :json
      end
    end
  end
end
