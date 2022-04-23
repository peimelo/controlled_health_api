# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReferencesController, type: :routing do
  describe 'routing' do
    it { should route(:get, 'api/references').to(action: :index, format: :json) }
    it { should_not route(:get, 'api/references/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, 'api/references').to(action: :create, format: :json) }
    it { should route(:put, 'api/references/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, 'api/references/1').to(action: :update, id: '1', format: :json) }
    it { should route(:delete, 'api/references/1').to(action: :destroy, id: '1', format: :json) }
  end
end
