require 'rails_helper'

RSpec.describe Amazon::Inventory do
  let(:element) { OpenStruct.new(text: '$19.98 - $49.10') }
  let(:alert) { 'This seller has only 112 of these available' }
  subject { described_class.new(nil) }
  before { allow(subject).to receive(:set_quantity!).and_return(true) }

  context 'with alert' do
    before { allow(subject).to receive(:quantity_alert_message).and_return(alert) }
    it { expect(subject.value).to eql(112) }
  end

  context 'without alert' do
    before { allow(subject).to receive(:quantity_alert_message).and_return(nil) }
    it { expect(subject.value).to eql(999) }
  end
end
