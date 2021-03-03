require 'rails_helper'

RSpec.describe Exam, type: :model do
  subject(:exam) { build :exam }

  describe 'associations' do
    it { should belong_to(:unit).required(false) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it {
      should validate_uniqueness_of(:name)
        .case_insensitive
        .scoped_to(%i[ancestry unit_id])
    }
  end
end
