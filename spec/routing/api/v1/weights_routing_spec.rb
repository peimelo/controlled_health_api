# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::WeightsController, type: :routing do
  describe 'routing' do
    it { should route(:get, 'api/weights').to(action: :index, format: :json) }
    it { should_not route(:get, 'api/weights/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, 'api/weights').to(action: :create, format: :json) }
    it { should route(:put, 'api/weights/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, 'api/weights/1').to(action: :update, id: '1', format: :json) }
    it { should route(:delete, 'api/weights/1').to(action: :destroy, id: '1', format: :json) }
  end
end
