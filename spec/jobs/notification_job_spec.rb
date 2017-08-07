require 'rails_helper'

RSpec.describe NotificationJob, type: :job do
  let(:product) { create(:product, asin: 'B012CS70R8') }
  let(:user) { create(:user) }
  subject(:job) { described_class.perform_later(user.id) }
  before { allow(job).to receive(:user).and_return(user) }

  describe '#perform' do
    context 'invalid user' do
      subject { job.perform(user.id) }
      before { allow(job).to receive(:user).and_return(nil) }
      it { is_expected.to be_nil }
    end

    it 'delivers NotificationMailer for each user' do
      create_list(:competitor, 2, product: product)
      expect(NotificationMailer).to receive(:daily_digest).exactly(2).times.and_call_original
      job.perform(product.id)
    end
  end
end
