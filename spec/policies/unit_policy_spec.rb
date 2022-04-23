# frozen_string_literal: true

require 'pundit/rspec'

describe UnitPolicy do
  subject { described_class }

  permissions :create? do
    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(User.new(admin: false), Unit.create(name: 'some'))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(admin: true), Unit.create(name: 'some'))
    end
  end

  permissions :update? do
    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(User.new(admin: false), Unit.create(name: 'some'))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(admin: true), Unit.create(name: 'some'))
    end
  end
end
