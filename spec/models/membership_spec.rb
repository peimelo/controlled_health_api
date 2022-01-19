require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Membership, type: :model do
  subject(:membership) { build :membership }

  describe 'associations' do
    it { should belong_to(:account) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:account_id) }
  end
end
