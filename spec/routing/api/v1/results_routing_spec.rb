# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ResultsController, type: :routing do
  describe 'routing' do
    it { should route(:get, 'api/results').to(action: :index, format: :json) }
    it { should route(:get, 'api/results/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, 'api/results').to(action: :create, format: :json) }
    it { should route(:put, 'api/results/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, 'api/results/1').to(action: :update, id: '1', format: :json) }
    it { should route(:delete, 'api/results/1').to(action: :destroy, id: '1', format: :json) }
  end
end
