class Group < ApplicationRecord
  extend FriendlyId
  include Concerns::ProductFinder

  belongs_to :user
  belongs_to :product
  has_many :competitors, dependent: :destroy
  has_many :products, through: :competitors

  validates :name, :product, :user, presence: true
  validates :competitors,
            associated: true,
            length: {
              maximum: Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP
            }
  validates_with Validators::MaxGroupsPerUserValidator

  accepts_nested_attributes_for :competitors
  friendly_id :name, use: %i[slugged finders]

  before_validation :mark_competitors_for_removal

  private

  def mark_competitors_for_removal
    competitors.each { |competitor| competitor.mark_for_destruction if competitor.product.blank? }
  end
end
