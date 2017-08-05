class Product < ApplicationRecord
  extend FriendlyId

  has_many :competitors, dependent: :destroy

  validates :asin, presence: true, uniqueness: true
  validates :title, :price, :reviews_count, :rank, :inventory, presence: true
  validates :price, :reviews_count, :rank, :inventory, numericality: { only_integer: true }

  has_paper_trail
  friendly_id :title, use: %i[slugged finders]
end
