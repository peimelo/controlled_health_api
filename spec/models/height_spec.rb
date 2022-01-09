require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Height, type: :model do
  let(:account) { create :account }

  describe 'associations' do
    it { should belong_to(:account) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:value) }

    it { should validate_numericality_of(:value).only_integer }
    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(20) }
    it { should validate_numericality_of(:value).is_less_than_or_equal_to(250) }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(account.heights_sorted('value', 'desc').to_sql).to eq account.heights.order('value desc').to_sql
      expect(account.heights_sorted('x', 'x').to_sql).to eq account.heights.order('date asc').to_sql
    end
  end

  describe '.value_by_date' do
    context 'with heights' do
      before(:all) do
        @account = create(:account)
        @height_10ya = create(:height, date: 10.years.ago, value: 100, account: @account)
        @height_20ya = create(:height, date: 20.years.ago, value: 200, account: @account)
        @heights_for_range = @account.heights_sorted('date', 'desc').pluck(:date, :value)
      end

      it 'returns the value of an earlier date' do
        expect(Height.value_by_date(5.years.ago, @heights_for_range)).to eq @height_10ya.value
        expect(Height.value_by_date(15.years.ago, @heights_for_range)).to eq @height_20ya.value
      end

      it 'returns the value of the last record' do
        expect(Height.value_by_date(25.years.ago, @heights_for_range)).to eq @height_20ya.value
      end
    end

    context 'without heights' do
      it 'returns zero' do
        expect(Height.value_by_date(5.years.ago, [])).to eq 0
      end
    end
  end
end
