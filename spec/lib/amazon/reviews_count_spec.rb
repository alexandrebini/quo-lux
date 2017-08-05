require 'rails_helper'

RSpec.describe Amazon::ReviewsCount do
  let(:page) { Nokogiri.parse("<span class='a-size-medium totalReviewCount'>49</span>") }
  subject { described_class.new(page) }

  its(:value) { is_expected.to eql(49) }
end
