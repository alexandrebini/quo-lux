class Competitor < ApplicationRecord
  include Concerns::ProductFinder

  belongs_to :group
  belongs_to :product
  has_one :user, through: :group

  validates :group, :product, presence: true
  validates_with Validators::MaxCompetitorsPerGroupValidator

  scope :by_rank, -> { joins(:product).order('products.rank') }
end
