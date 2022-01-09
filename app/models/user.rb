# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :memberships, dependent: :delete_all
  has_many :accounts, through: :memberships
  has_many :accounts_owner, foreign_key: :owner_id,
                            class_name: 'Account',
                            dependent: :restrict_with_exception

  before_validation :set_uid
  validate :password_complexity

  private

  def password_complexity
    return if password.nil?

    errors.add :password, :complexity unless CheckPasswordComplexityService.call(password)
  end

  def set_uid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end
