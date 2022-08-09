require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/units', type: :request do
  let(:user) { create :confirmed_user_admin }
  let(:unit) { create :unit }

  let(:valid_attributes) { attributes_for :unit }
  let(:invalid_attributes) { attributes_for :invalid_unit }

  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /index' do
    it 'renders a successful response' do
      unit
      get api_units_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_units_url, headers: {}, as: :json }
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Unit' do
        expect do
          post api_units_url,
               params: { unit: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Unit, :count).by(1)
      end

      it 'renders a JSON response with the new unit' do
        post api_units_url,
             params: { unit: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Unit' do
        expect do
          post api_units_url,
               params: { unit: invalid_attributes }, as: :json
        end.to change(Unit, :count).by(0)
      end

      it 'renders a JSON response with errors for the new unit' do
        post api_units_url,
             params: { unit: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_units_url,
             params: { unit: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :unit, name: 'asdfghjkl' }

      it 'updates the requested unit' do
        patch api_unit_url(unit),
              params: { unit: new_attributes }, headers: valid_headers, as: :json
        unit.reload
        expect(unit.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response with the unit' do
        patch api_unit_url(unit),
              params: { unit: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the unit' do
        patch api_unit_url(unit),
              params: { unit: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_unit_url(unit),
              params: { unit: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested unit' do
      unit
      expect do
        delete api_unit_url(unit), headers: valid_headers, as: :json
      end.to change(Unit, :count).by(-1)
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete api_unit_url(unit), headers: {}, as: :json
      end
    end
  end
end
