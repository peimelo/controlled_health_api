# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :routing do
  describe 'routing' do
    it { should route(:get, 'api/accounts').to(action: :index, format: :json) }
    it { should route(:get, 'api/accounts/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, 'api/accounts').to(action: :create, format: :json) }
    it { should route(:put, 'api/accounts/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, 'api/accounts/1').to(action: :update, id: '1', format: :json) }
    it { should_not route(:delete, 'api/accounts/1').to(action: :destroy, id: '1', format: :json) }
  end
end
