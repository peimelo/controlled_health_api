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

  has_many :heights, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :weights, dependent: :destroy

  delegate :sorted, to: :heights, prefix: true
  delegate :sorted, to: :results, prefix: true
  delegate :sorted, to: :weights, prefix: true

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
