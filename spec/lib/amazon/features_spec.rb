require 'rails_helper'

RSpec.describe Amazon::Features do
  let(:html) do
    <<-EOS
      <div id='feature-bullets'>
        <ul>
          <li><span> Durable aluminum alloy </span></li>
          <li><span> 31/32" tapered handle with All Sports grip </span></li>
          <li><span> 2 5/8" barrel</span></li>
          <li><span> 1-Year Warranty </span></li>
        </ul>
      </div>
    EOS
  end
  let(:page) { Nokogiri.parse(html) }
  subject { described_class.new(page) }

  its(:value) { is_expected.to include('Durable aluminum alloy') }
  its(:value) { is_expected.to include('31/32" tapered handle with All Sports grip') }
  its(:value) { is_expected.to include('2 5/8" barrel') }
  its(:value) { is_expected.to include('1-Year Warranty') }
end
