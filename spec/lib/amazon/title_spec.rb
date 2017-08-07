require 'rails_helper'

RSpec.describe Amazon::Title do
  let(:element) { OpenStruct.new(text: ' Louisville Slugger Genuine Series 3X ') }
  subject { described_class.new(nil) }
  before { allow(subject).to receive(:element).and_return(element) }

  its(:value) { is_expected.to eql('Louisville Slugger Genuine Series 3X') }
end
