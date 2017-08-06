module GroupsHelper
  MAX_COMPETITORS = Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP

  def setup_group(group)
    missing_competitors = MAX_COMPETITORS - group.competitors.size
    missing_competitors.times { group.competitors.build }
    group
  end

  def rank_change(product)
    difference = get_attribute_difference(product, :rank)
    render_attribute_difference(number_with_delimiter(difference), difference)
  end

  def price_change(product)
    difference = get_attribute_difference(product, :price)
    render_attribute_difference(Money.new(difference).format, difference)
  end

  def reviews_count_change(product)
    difference = get_attribute_difference(product, :reviews_count)
    render_attribute_difference(number_with_delimiter(difference), difference)
  end

  def inventory_change(product)
    difference = get_attribute_difference(product, :inventory)
    render_attribute_difference(number_with_delimiter(difference), difference)
  end

  private

  def get_attribute_difference(product, attr)
    previous = product.paper_trail.version_at(1.day.ago).try(attr)
    return if previous.blank? || previous == product.read_attribute(attr)
    product.read_attribute(attr) - previous
  end

  def render_attribute_difference(value, difference)
    return if difference.blank?
    if difference.positive?
      content_tag(:small, class: 'green-text text-darken-1') { "+#{value}" }
    else
      content_tag(:small, class: 'red-text text-darken-1') { "-#{value}" }
    end
  end
end
