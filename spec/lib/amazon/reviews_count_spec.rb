require 'rails_helper'

RSpec.describe Amazon::ReviewsCount do
  let(:element) { OpenStruct.new(text: '49') }
  subject { described_class.new(nil) }
  before { allow(subject).to receive(:element).and_return(element) }

  its(:value) { is_expected.to eql(49) }
end
