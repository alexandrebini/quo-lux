class Group < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  belongs_to :product
  has_many :competitors, dependent: :destroy
  has_many :products, through: :competitors

  validates :name, :product, :user, presence: true
  validates :competitors, length: {
    maximum: Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP
  }
  validates_with Validators::MaxGroupsPerUserValidator

  attr_writer :product_finder
  accepts_nested_attributes_for :competitors
  friendly_id :name, use: %i[slugged finders]

  before_validation :set_product

  def product_finder
    return product.try(:asin) if @product_finder.blank?
    @product_finder
  end

  private

  def set_product
    asin = Utils::Asin.from_url(product_finder)
    return if asin.blank?
    self.product = Product.where(asin: asin).first_or_create
  end
end
