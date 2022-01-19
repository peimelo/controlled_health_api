require 'rails_helper'

RSpec.describe Account, type: :model do
  subject(:account) { build :account }

  describe 'associations' do
    it { should have_many(:alimentations).dependent(:destroy) }
    it { should have_many(:heights).dependent(:destroy) }
    it { should have_many(:results).dependent(:destroy) }
    it { should have_many(:weights).dependent(:destroy) }

    it { should have_many(:invitations).dependent(:delete_all) }
    it { should have_many(:memberships).dependent(:delete_all) }
    it { should have_many(:users).through(:memberships) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:owner_id) }
  end

  describe 'concerns' do
    it '.sorted' do
      expect(Account.sorted('name', 'desc').to_sql).to eq Account.order('name desc').to_sql
      expect(Account.sorted('x', 'x').to_sql).to eq Account.order('name asc').to_sql
    end
  end
end
