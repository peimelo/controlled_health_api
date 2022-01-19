require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/results', type: :request do
  let(:membership) { create :membership }
  let(:user) { membership.user }
  let(:account) { membership.account }
  let(:result) { create :result, account: account }
  let(:result_two) { create :result, account: create(:membership).account }

  let(:valid_attributes) { attributes_for :result, account: account }
  let(:invalid_attributes) { attributes_for :invalid_result, account: account }

  let(:valid_headers) { user.create_new_auth_token.merge!('account' => account.id.to_s) }

  describe 'GET /index' do
    it 'renders a successful response' do
      result
      get api_results_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders only results from logged user' do
      result
      result_two

      get api_results_url, headers: valid_headers, as: :json
      expect(json_response[:results].size).to eq 1
      expect(json_response[:results][0][:id]).to eq result.id
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_results_url, headers: {}, as: :json }
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_result_url(result), headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        get api_result_url(result_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        get api_result_url(result), headers: {}, as: :json
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Result' do
        expect do
          post api_results_url,
               params: { result: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Result, :count).by(1)
      end

      it 'renders a JSON response with the new result' do
        post api_results_url,
             params: { result: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Result' do
        expect do
          post api_results_url,
               params: { result: invalid_attributes }, as: :json
        end.to change(Result, :count).by(0)
      end

      it 'renders a JSON response with errors for the new result' do
        post api_results_url,
             params: { result: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_results_url,
             params: { result: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for :result, description: 'New description' }

      it 'updates the requested result' do
        patch api_result_url(result),
              params: { result: new_attributes }, headers: valid_headers, as: :json
        result.reload
        expect(result.description).to eq(new_attributes[:description])
      end

      it 'renders a JSON response with the result' do
        patch api_result_url(result),
              params: { result: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the result' do
        patch api_result_url(result),
              params: { result: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        patch api_result_url(result_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_result_url(result),
              params: { result: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested result' do
      result
      expect do
        delete api_result_url(result), headers: valid_headers, as: :json
      end.to change(Result, :count).by(-1)
    end

    it_behaves_like "trying to access another user's resource" do
      let(:url) do
        delete api_result_url(result_two), headers: valid_headers, as: :json
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        delete api_result_url(result), headers: {}, as: :json
      end
    end
  end
end
