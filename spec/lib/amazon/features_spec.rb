require 'rails_helper'

RSpec.describe Amazon::Features do
  let(:elements) do
    [
      OpenStruct.new(text: 'Durable aluminum alloy'),
      OpenStruct.new(text: ' 31/32" tapered handle with All Sports grip '),
      OpenStruct.new(text: '2 5/8" barrel'),
      OpenStruct.new(text: '1-Year Warranty'),
      OpenStruct.new(text: ' ')
    ]
  end

  subject { described_class.new(nil) }
  before { allow(subject).to receive(:elements).and_return(elements) }

  its(:value) { is_expected.to include('Durable aluminum alloy') }
  its(:value) { is_expected.to include('31/32" tapered handle with All Sports grip') }
  its(:value) { is_expected.to include('2 5/8" barrel') }
  its(:value) { is_expected.to include('1-Year Warranty') }
end
