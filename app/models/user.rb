class User < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :products, through: :groups, source: :products

  validates :groups, length: {
    maximum: Validators::MaxGroupsPerUserValidator::MAX_GROUPS_PER_USER
  }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
