require 'rails_helper'

Element = Struct.new(:url) do
  def attribute_value(_attr)
    url
  end
end

RSpec.describe Amazon::Images do
  let(:elements) do
    [
      Element.new('https://amazon.com/images/I/71XaxP6VRgL.jpg'),
      Element.new('https://amazon.com/images/I/31Pral-j3cL.jpg'),
      Element.new('foo'),
      Element.new('')
    ]
  end

  subject { described_class.new(nil) }
  before do
    allow(subject).to receive(:enable_images!).and_return(true)
    allow(subject).to receive(:elements).and_return(elements)
  end

  its(:value) { is_expected.to include('https://amazon.com/images/I/71XaxP6VRgL.jpg') }
  its(:value) { is_expected.to include('https://amazon.com/images/I/31Pral-j3cL.jpg') }
  its(:value) { is_expected.to_not include('foo') }
  its(:value) { is_expected.to_not include('') }
end
