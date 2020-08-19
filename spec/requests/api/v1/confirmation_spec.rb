require 'rails_helper'

RSpec.describe 'Confirmations', type: :request do
  let(:valid_attributes) { attributes_for :user }

  describe 'POST /create' do
    it 're-sends confirmation' do
      user = User.create! valid_attributes
      post '/api/auth/confirmation', params: { email: user.email }
      expect(response).to have_http_status(:ok)
    end
  end
end
