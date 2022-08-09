require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe '/accounts', type: :request do
  let(:user) { create :confirmed_user_admin }
  let(:account) { create :account }

  let(:valid_attributes) { attributes_for :account }
  let(:invalid_attributes) { attributes_for :invalid_account }

  let(:valid_headers) { user.create_new_auth_token }

  describe 'GET /index' do
    it 'renders a successful response' do
      account
      get api_accounts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it_behaves_like 'user not logged in' do
      let(:url) { get api_accounts_url, headers: {}, as: :json }
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Account' do
        expect do
          post api_accounts_url,
               params: { account: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Account, :count).by(1)
      end

      it 'renders a JSON response with the new account' do
        post api_accounts_url,
             params: { account: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Account' do
        expect do
          post api_accounts_url,
               params: { account: invalid_attributes }, as: :json
        end.to change(Account, :count).by(0)
      end

      it 'renders a JSON response with errors for the new account' do
        post api_accounts_url,
             params: { account: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    it_behaves_like 'user not logged in' do
      let(:url) do
        post api_accounts_url,
             params: { account: valid_attributes },
             headers: {},
             as: :json
      end
    end
  end

  describe 'PATCH /update' do
    # context 'with valid parameters' do
    #   let(:new_attributes) { attributes_for :account, name: 'asdfghjkl' }
    #
    #   it 'updates the requested account' do
    #     patch api_account_url(account),
    #           params: { account: new_attributes }, headers: valid_headers, as: :json
    #     account.reload
    #     expect(account.name).to eq(new_attributes[:name])
    #   end
    #
    #   it 'renders a JSON response with the account' do
    #     patch api_account_url(account),
    #           params: { account: new_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:ok)
    #     expect(response.content_type).to eq('application/json; charset=utf-8')
    #   end
    # end

    # context 'with invalid parameters' do
    #   it 'renders a JSON response with errors for the account' do
    #     patch api_account_url(account),
    #           params: { account: invalid_attributes }, headers: valid_headers, as: :json
    #     expect(response).to have_http_status(:unprocessable_entity)
    #     expect(response.content_type).to eq('application/json; charset=utf-8')
    #   end
    # end

    it_behaves_like 'user not logged in' do
      let(:url) do
        patch api_account_url(account),
              params: { account: valid_attributes },
              headers: {},
              as: :json
      end
    end
  end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested account' do
  #     account
  #     expect do
  #       delete api_account_url(account), headers: valid_headers, as: :json
  #     end.to change(Account, :count).by(-1)
  #   end
  #
  #   it_behaves_like 'user not logged in' do
  #     let(:url) do
  #       delete api_account_url(account), headers: {}, as: :json
  #     end
  #   end
  # end
end
