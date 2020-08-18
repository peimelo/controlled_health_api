require 'rails_helper'

RSpec.describe Api::V1::WeightsController, type: :controller do
  it { should use_before_action(:authenticate_api_user!) }
end
