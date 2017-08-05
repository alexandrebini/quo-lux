class Group < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :competitors, dependent: :destroy
  has_many :products, through: :competitors

  validates :user, :name, presence: true
  validates :competitors, length: {
    maximum: Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP
  }
  validates_with Validators::MaxGroupsPerUserValidator

  friendly_id :name, use: %i[slugged finders]
end
