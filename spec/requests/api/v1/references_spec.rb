require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/references', type: :request do
  let(:user) { create :confirmed_user_admin }
  let(:reference) { create :reference }

  let(:valid_attributes) { attributes_for :reference }
  let(:invalid_attributes) { attributes_for :invalid_reference }

  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /index' do
    it 'renders a successful response' do
      reference
      get api_references_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_references_url, headers: {}, as: :json }
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Reference' do
        expect do
          post api_references_url,
               params: { reference: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Reference, :count).by(1)
      end

      it 'renders a JSON response with the new reference' do
        post api_references_url,
             params: { reference: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Reference' do
        expect do
          post api_references_url,
               params: { reference: invalid_attributes }, as: :json
        end.to change(Reference, :count).by(0)
      end

      it 'renders a JSON response with errors for the new reference' do
        post api_references_url,
             params: { reference: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_references_url,
             params: { reference: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :reference, name: 'asdfghjkl' }

      it 'updates the requested reference' do
        patch api_reference_url(reference),
              params: { reference: new_attributes }, headers: valid_headers, as: :json
        reference.reload
        expect(reference.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the reference' do
        patch api_reference_url(reference),
              params: { reference: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the reference' do
        patch api_reference_url(reference),
              params: { reference: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_reference_url(reference),
              params: { reference: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested reference' do
      reference
      expect do
        delete api_reference_url(reference), headers: valid_headers, as: :json
      end.to change(Reference, :count).by(-1)
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete api_reference_url(reference), headers: {}, as: :json
      end
    end
  end
end
