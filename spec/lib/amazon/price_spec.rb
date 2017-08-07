require 'rails_helper'

RSpec.describe Amazon::Price do
  let(:element) { OpenStruct.new(text: '$19.98', exists?: true) }
  subject { described_class.new(nil) }
  before { allow(subject).to receive(:element).and_return(element) }

  its(:value) { is_expected.to eql(1998) }
end
