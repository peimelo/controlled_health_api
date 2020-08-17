require 'rails_helper'

RSpec.describe Api::V1::HeightsController, type: :routing do
  describe 'routing' do
    it { should route(:get, 'api/heights').to(action: :index, format: :json) }
    it { should route(:get, 'api/heights/1').to(action: :show, id: '1', format: :json) }
    it { should route(:post, 'api/heights').to(action: :create, format: :json) }
    it { should route(:put, 'api/heights/1').to(action: :update, id: '1', format: :json) }
    it { should route(:patch, 'api/heights/1').to(action: :update, id: '1', format: :json) }
    it { should route(:delete, 'api/heights/1').to(action: :destroy, id: '1', format: :json) }
  end
end
