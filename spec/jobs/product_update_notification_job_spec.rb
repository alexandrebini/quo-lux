require 'rails_helper'

RSpec.describe ProductUpdateNotificationJob, type: :job do
  let(:product) { create(:product, asin: 'B012CS70R8') }
  subject(:job) { described_class.perform_later(product.id) }
  before { allow(job).to receive(:product).and_return(product) }

  describe '#perform' do
    context 'invalid product' do
      subject { job.perform(product.id) }
      before { allow(job).to receive(:product).and_return(nil) }
      it { is_expected.to be_nil }
    end

    it 'delivers NotificationMailer for each user' do
      create_list(:competitor, 2, product: product)
      expect(NotificationMailer).to receive(:product_update).exactly(2).times.and_call_original
      job.perform(product.id)
    end
  end
end
