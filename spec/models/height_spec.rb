require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Height, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:value) }

    it { should validate_numericality_of(:value).only_integer }
    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(20) }
    it { should validate_numericality_of(:value).is_less_than_or_equal_to(250) }
  end

  describe '.value_by_date' do
    before(:all) do
      @user = create(:user)
    end

    context 'with heights' do
      before(:all) do
        @height1 = create(:height, date: 10.years.ago, value: 100, user: @user)
        @height2 = create(:height, date: 20.years.ago, value: 200, user: @user)
      end

      it 'returns the value of an earlier date' do
        expect(Height.value_by_date(5.years.ago, @user.id)).to eq @height1.value
        expect(Height.value_by_date(15.years.ago, @user.id)).to eq @height2.value
      end

      it 'returns the value of the last record' do
        expect(Height.value_by_date(25.years.ago, @user.id)).to eq @height2.value
      end
    end

    context 'without heights' do
      it 'returns zero' do
        Height.delete_all
        expect(Height.value_by_date(5.years.ago, @user.id)).to eq 0
      end
    end
  end
end
