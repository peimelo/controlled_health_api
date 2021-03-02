require 'rails_helper'

RSpec.describe Reference, type: :model do
  subject(:reference) { build :reference }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
