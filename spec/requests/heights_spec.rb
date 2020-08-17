require 'rails_helper'

RSpec.describe '/heights', type: :request do
  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :height, user_id: user.id }
  let(:invalid_attributes) { attributes_for :invalid_height }
  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /index' do
    it 'renders a successful response' do
      Height.create! valid_attributes
      get api_heights_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      height = Height.create! valid_attributes
      get api_height_url(height), headers: valid_headers, as: :json
      expect(response).to be_successful
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
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :height, value: 1.97 }

      it 'updates the requested height' do
        height = Height.create! valid_attributes
        patch api_height_url(height),
              params: { height: new_attributes }, headers: valid_headers, as: :json
        height.reload
        expect(height.value).to eq(1.97)
      end

      it 'renders a JSON response with the height' do
        height = Height.create! valid_attributes
        patch api_height_url(height),
              params: { height: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the height' do
        height = Height.create! valid_attributes
        patch api_height_url(height),
              params: { height: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested height' do
      height = Height.create! valid_attributes
      expect do
        delete api_height_url(height), headers: valid_headers, as: :json
      end.to change(Height, :count).by(-1)
    end
  end
end
