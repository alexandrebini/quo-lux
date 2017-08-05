require 'rails_helper'

RSpec.describe Amazon::Price do
  let(:page) { Nokogiri.parse("<span id='priceblock_ourprice'>$19.98 - $49.10</span>") }
  subject { described_class.new(page) }

  its(:value) { is_expected.to eql(1998) }
  its(:value) { is_expected.to_not eql(4910) }
end
