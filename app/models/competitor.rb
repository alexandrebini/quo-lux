class Competitor < ApplicationRecord
  include Concerns::ProductFinder

  belongs_to :group
  belongs_to :product

  validates :group, :product, presence: true
  validates_with Validators::MaxCompetitorsPerGroupValidator

  scope :by_rank, -> { joins(:product).order('products.rank') }
end
