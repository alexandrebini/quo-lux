require 'rails_helper'

RSpec.describe Amazon::Features do
  let(:elements) do
    [
      'Durable aluminum alloy',
      ' 31/32" tapered handle with All Sports grip ',
      '2 5/8" barrel',
      '1-Year Warranty',
      ' '
    ]
  end

  subject { described_class.new() }
  before { allow(subject).to receive(elements).and_return(elements) }

  its(:value) { is_expected.to include('Durable aluminum alloy') }
  its(:value) { is_expected.to include('31/32" tapered handle with All Sports grip') }
  its(:value) { is_expected.to include('2 5/8" barrel') }
  its(:value) { is_expected.to include('1-Year Warranty') }
end
