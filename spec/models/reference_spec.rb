require 'rails_helper'

RSpec.describe Reference, type: :model do
  subject(:reference) { build :reference }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(Reference.sorted('name', 'desc').to_sql).to eq Reference.order('name desc').to_sql
      expect(Reference.sorted('x', 'x').to_sql).to eq Reference.order('name asc').to_sql
    end
  end
end
