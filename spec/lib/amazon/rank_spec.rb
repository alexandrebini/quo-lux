require 'rails_helper'

RSpec.describe Amazon::Rank do
  let(:element) { OpenStruct.new(text: 'Amazon Best Sellers Rank:</b> #8,607 in Sports') }
  subject { described_class.new(nil) }
  before { allow(subject).to receive(:element).and_return(element) }

  its(:value) { is_expected.to eql(8607) }
end
