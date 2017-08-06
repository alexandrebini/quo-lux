require 'rails_helper'

RSpec.describe ProductFetcherJob, type: :job, vcr: true do
  let(:product) { create(:product, asin: 'B012CS70R8') }
  subject(:job) { described_class.perform_later(product.id) }
  before { allow(job).to receive(:product).and_return(product) }

  describe '#perform' do
    context 'invalid product' do
      subject { job.perform(product.id) }
      before { allow(job).to receive(:product).and_return(nil) }
      it { is_expected.to be_nil }
    end

    context 'already fetching product' do
      subject { job.perform(product.id) }
      before { allow(job).to receive(:product).and_return(OpenStruct.new(fetching?: true)) }
      it { is_expected.to be_nil }
    end

    it 'call :on_start before fetching' do
      expect(job).to receive(:on_start)
      job.perform(product.id)
    end

    it 'call :on_error when exception happens' do
      expect(job).to receive(:on_error)
      allow(job).to receive(:fetch_product).and_raise(StandardError)
      job.perform(product.id)
    end

    it 'call :on_success when everything is ok' do
      expect(job).to receive(:on_success)
      job.perform(product.id)
    end

    it 'mark product as :ready when everything is ok' do
      expect { job.perform(product.id) }.to change { product.status }.from('pending').to('ready')
    end
  end

  describe '#fetch_product' do
    it 'call :on_error when amazon_product is empty' do
      expect(job).to receive(:on_error)
      allow(job).to receive(:amazon_product).and_return({})
      job.fetch_product
    end

    context 'update product attributes' do
      let!(:new_product) { attributes_for(:product, asin: 'B012CS70R8') }
      before do
        allow(job).to receive(:amazon_product).and_return(new_product)
        job.fetch_product
      end
      subject { product }
      its(:features) { is_expected.to eql(new_product[:features]) }
      its(:images) { is_expected.to eql(new_product[:images]) }
      its(:inventory) { is_expected.to eql(new_product[:inventory]) }
      its(:price) { is_expected.to eql(new_product[:price]) }
      its(:rank) { is_expected.to eql(new_product[:rank]) }
      its(:reviews_count) { is_expected.to eql(new_product[:reviews_count]) }
      its(:title) { is_expected.to eql(new_product[:title]) }
    end

    it 'call :on_success' do
      expect(job).to receive(:on_success)
      job.fetch_product
    end
  end

  it '#on_start' do
    expect { job.send(:on_start) }.to change { product.status }.from('pending').to('fetching')
  end

  describe '#on_error' do
    let(:now) { Time.now }
    before do
      allow(job).to receive(:next_status).and_return('ready')
      allow(Time).to receive(:now).and_return(Time.now.midday)
      job.send(:on_error, 'error log')
    end
    subject { product }
    its(:status) { is_expected.to eql('ready') }
    its(:last_fetch_status) { is_expected.to eql('error') }
    its(:last_fetch_log) { is_expected.to eql('error log') }
    its(:last_fetch_at) { is_expected.to eql(now) }
  end

  describe '#on_success' do
    let(:now) { Time.now }
    before do
      allow(job).to receive(:next_status).and_return('ready')
      allow(Time).to receive(:now).and_return(now)
      job.send(:on_success)
    end
    subject { product }
    its(:status) { is_expected.to eql('ready') }
    its(:last_fetch_status) { is_expected.to eql('success') }
    its(:last_fetch_log) { is_expected.to eql(nil) }
    its(:last_fetch_at) { is_expected.to eql(now) }
  end

  describe '#on_finish' do
    it 'mark product as :pending if the current status is :fetching' do
      allow(job).to receive(:product).and_return(OpenStruct.new(fetching?: true))
      job.send(:on_finish)
      expect(product.pending?).to be_truthy
    end
  end
end
