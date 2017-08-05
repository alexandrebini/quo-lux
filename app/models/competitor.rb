class Competitor < ApplicationRecord
  belongs_to :group
  belongs_to :product

  validates :group, :product, presence: true
  validates_with Validators::MaxCompetitorsPerGroupValidator
end
