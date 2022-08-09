require 'rails_helper'

RSpec.describe Alimentation, type: :model do
  describe 'associations' do
    it { should belong_to(:account) }
    it { should belong_to(:meal) }
    it { should have_many(:alimentation_food).dependent(:delete_all) }
  end
end
