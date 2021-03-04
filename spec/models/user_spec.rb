require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:heights).dependent(:destroy) }
    it { should have_many(:results).dependent(:destroy) }
    it { should have_many(:weights).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
end
