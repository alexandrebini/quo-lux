class Product < ApplicationRecord
  extend FriendlyId
  extend Memoist

  REQUIRED_ATTRIBUTES = %i[title price rank reviews_count].freeze
  VERSIONING_ATTRIBUTES = %i[features images inventory price rank reviews_count title].freeze

  has_many :competitors, dependent: :destroy
  has_many :groups, through: :competitors
  has_many :users, through: :competitors

  validates :asin, presence: true, uniqueness: true
  validates :price, :reviews_count, :rank, :inventory,
            numericality: { only_integer: true },
            allow_blank: true

  has_paper_trail only: %i[asin features images inventory price rank reviews_count title]
  friendly_id :asin, use: %i[slugged finders]
  enum status: %i[pending fetching ready]
  enum last_fetch_status: %i[unknown success error]

  after_commit :enqueue_fetcher, on: %i[create update]

  scope :by_rank, -> { order(:rank) }

  def url
    return if asin.blank?
    Utils::Asin.url(asin)
  end

  def missing_attributes?
    REQUIRED_ATTRIBUTES.any? { |attr| read_attribute(attr).blank? }
  end

  def diff(date)
    ProductDiff.new(self, date)
  end

  private

  def enqueue_fetcher
    return unless previous_changes.key?(:asin)
    ProductFetcherJob.perform_later(id)
  end

  memoize :diff
end
