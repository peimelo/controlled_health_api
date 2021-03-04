require 'rails_helper'

RSpec.describe ReferenceRange, type: :model do
  describe 'associations' do
    it { should belong_to(:exam) }
    it { should belong_to(:reference).required(false) }
  end

  describe 'numericality' do
    it {
      should validate_numericality_of(:minimum_age)
        .is_less_than_or_equal_to(199.999)
    }
    it {
      should validate_numericality_of(:maximum_age)
        .is_less_than_or_equal_to(199.999)
    }

    it {
      should validate_numericality_of(:minimum_value)
        .is_less_than_or_equal_to(99_999_999.99)
    }
    it {
      should validate_numericality_of(:maximum_value)
        .is_less_than_or_equal_to(99_999_999.99)
    }
  end
end
