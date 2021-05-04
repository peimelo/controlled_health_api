require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Weight, type: :model do
  let(:user) { create :user }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:value) }

    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(3) }
    it { should validate_numericality_of(:value).is_less_than_or_equal_to(400) }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(user.weights_sorted('value', 'desc').to_sql).to eq user.weights.order('value desc').to_sql
      expect(user.weights_sorted('x', 'x').to_sql).to eq user.weights.order('date asc').to_sql
    end
  end

  describe 'range' do
    before(:all) do
      @weight = create(:weight)
    end

    it '#minimum' do
      expect(@weight.minimum(100)).to eq 18.49
    end

    it '#maximum' do
      expect(@weight.maximum(100)).to eq 24.99
    end
  end
end
