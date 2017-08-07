class ProductDiff
  extend Memoist
  attr_accessor :product, :date

  def initialize(product, date)
    @product = product
    @date = date
  end

  def changeset
    return {} if product.blank?

    {}.tap do |changeset|
      Product::VERSIONING_ATTRIBUTES.each do |attr|
        attr_diff = diff(attr)
        next if attr_diff.blank?
        changeset[attr] = attr_diff
      end
    end
  end

  def diff(attr)
    return if product.blank?
    return if previous[attr] == current[attr]
    [previous[attr], current[attr]]
  end

  def previous
    product.paper_trail.version_at(date) || {}
  end

  memoize :changeset, :diff, :previous
  alias current product
  alias inspect changeset
end
