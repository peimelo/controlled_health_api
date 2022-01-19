require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:memberships).dependent(:delete_all) }
    it { should have_many(:accounts).through(:memberships) }
    it { should have_many(:accounts_owner).with_foreign_key('owner_id').class_name('Account') }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe 'callbacks' do
    context 'before_validation' do
      it 'should set uid as email' do
        user = User.new attributes_for :user_without_uid
        expect(user.uid).to eq('')
        user.save
        expect(user.uid).to eq(user.email)
      end
    end
  end

  describe 'password_complexity' do
    context 'valid' do
      ['`', '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')',
       '-', '_', '=', '+', '[', ']', '{', '}', '\\', '|', ';', ':',
       "'", '"', ',', '.', '<', '>', '/', '?'].each do |extra_char|
        it { should allow_value("Password12#{extra_char}").for(:password) }
      end
    end

    context 'invalid' do
      %w(12345678 password =+[]{}\| PASSWORD password1 pa$$word Password1 password_1).each do |password|
        it { should_not allow_value(password).for(:password) }
      end
    end
  end
end
