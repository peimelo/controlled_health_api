require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Result, type: :model do
  let(:account) { create :account }
  subject(:result) { build :result }

  describe 'associations' do
    it { should belong_to(:account) }
    it { should have_many(:exam).through(:exam_result) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:date).scoped_to(:description).case_insensitive }

    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:description).scoped_to(:date) }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(account.results_sorted('description', 'desc').to_sql).to eq account.results.order('description desc').to_sql
      expect(account.results_sorted('x', 'x').to_sql).to eq account.results.order('date asc').to_sql
    end
  end
end
