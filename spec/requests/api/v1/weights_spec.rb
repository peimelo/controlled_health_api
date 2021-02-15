require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/weights', type: :request do
  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :weight, user_id: user.id }
  let(:invalid_attributes) { attributes_for :invalid_weight }
  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /index' do
    it 'renders a successful response' do
      Weight.create! valid_attributes
      get api_weights_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      weight = Weight.create! valid_attributes
      get api_weight_url(weight), headers: valid_headers, as: :json
      expect(response).to be_successful
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
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :weight, value: 99.98 }

      it 'updates the requested weight' do
        weight = Weight.create! valid_attributes
        patch api_weight_url(weight),
              params: { weight: new_attributes }, headers: valid_headers, as: :json
        weight.reload
        expect(weight.value).to eq(99.98)
      end

      it 'renders a JSON response with the weight' do
        weight = Weight.create! valid_attributes
        patch api_weight_url(weight),
              params: { weight: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the weight' do
        weight = Weight.create! valid_attributes
        patch api_weight_url(weight),
              params: { weight: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested weight' do
      weight = Weight.create! valid_attributes
      expect do
        delete api_weight_url(weight), headers: valid_headers, as: :json
      end.to change(Weight, :count).by(-1)
    end
  end
end
