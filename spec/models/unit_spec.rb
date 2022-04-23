require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject(:unit) { build :unit }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(Unit.sorted('name', 'desc').to_sql).to eq Unit.order('name desc').to_sql
      expect(Unit.sorted('x', 'x').to_sql).to eq Unit.order('name asc').to_sql
    end
  end
end
