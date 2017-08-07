require 'rails_helper'

RSpec.describe Amazon::Price do
  let(:element) { OpenStruct.new(text: '$19.98 - $49.10') }
  subject { described_class.new(nil) }
  before { allow(subject).to receive(:element).and_return(element) }

  its(:value) { is_expected.to eql(1998) }
  its(:value) { is_expected.to_not eql(4910) }
end
