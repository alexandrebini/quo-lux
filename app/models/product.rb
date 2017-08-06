class Product < ApplicationRecord
  extend FriendlyId

  has_many :competitors, dependent: :destroy

  validates :asin, presence: true, uniqueness: true
  validates :price, :reviews_count, :rank, :inventory,
            numericality: { only_integer: true },
            allow_blank: true

  has_paper_trail only: %i[asin features images inventory price rank reviews_count title]
  friendly_id :asin, use: %i[slugged finders]
  enum status: %i[pending fetching ready]
  enum last_fetch_status: %i[unknown success error]

  after_commit :enqueue_fetcher, on: %i[create update], if: proc { |record|
    record.previous_changes.key?(:sin)
  }

  scope :by_rank, -> { order(:rank) }

  def url
    return if asin.blank?
    Utils::Asin.url(asin)
  end

  def missing_attributes?
    required_attributes = %i[title price rank reviews_count]
    required_attributes.any? { |attr| read_attribute(attr).blank? }
  end

  private

  def enqueue_fetcher
    ProductFetcherJob.perform_later(id)
  end
end
