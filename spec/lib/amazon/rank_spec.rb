require 'rails_helper'

RSpec.describe Amazon::Rank do
  let(:html) do
    <<-EOS
      <li id="SalesRank">
        <b>Amazon Best Sellers Rank:</b> #8,607 in Sports &amp; Outdoors"
      </li>
    EOS
  end
  let(:page) { Nokogiri.parse(html) }
  subject { described_class.new(page) }

  its(:value) { is_expected.to eql(8607) }
end
