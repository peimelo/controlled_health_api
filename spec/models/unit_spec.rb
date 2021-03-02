require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject(:unit) { build :unit }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
