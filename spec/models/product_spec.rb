require 'rails_helper'

RSpec.describe Product do
  it { should have_db_column(:asin).with_options(null: false) }
  it { should have_db_column(:created_at).with_options(null: false) }
  it { should have_db_column(:features).with_options(null: false, default: []) }
  it { should have_db_column(:images).with_options(null: false, default: []) }
  it { should have_db_column(:inventory).with_options(null: true) }
  it { should have_db_column(:last_fetch_at) }
  it { should have_db_column(:last_fetch_log) }
  it { should have_db_column(:last_fetch_status).with_options(null: false, default: :unknown) }
  it { should have_db_column(:price).with_options(null: true) }
  it { should have_db_column(:rank).with_options(null: true) }
  it { should have_db_column(:reviews_count).with_options(null: true) }
  it { should have_db_column(:slug).with_options(null: false) }
  it { should have_db_column(:status).with_options(null: false, default: :pending) }
  it { should have_db_column(:title).with_options(null: true) }
  it { should have_db_column(:updated_at).with_options(null: false) }
  it { should have_db_index(:asin).unique(true) }
  it { should have_db_index(:last_fetch_status) }
  it { should have_db_index(:price) }
  it { should have_db_index(:rank) }
  it { should have_db_index(:reviews_count) }
  it { should have_db_index(:slug).unique(true) }
  it { should have_db_index(:status) }

  it { should have_many(:competitors).dependent(:destroy) }
  it { should have_many(:groups).through(:competitors) }
  it { should have_many(:users).through(:competitors) }

  it { should validate_presence_of(:asin) }
  it { should_not validate_presence_of(:inventory) }
  it { should_not validate_presence_of(:price) }
  it { should_not validate_presence_of(:rank) }
  it { should_not validate_presence_of(:reviews_count) }
  it { should_not validate_presence_of(:title) }
  it { should validate_uniqueness_of(:asin) }
  it { should validate_numericality_of(:price).only_integer.allow_nil }
  it { should validate_numericality_of(:reviews_count).only_integer.allow_nil }
  it { should validate_numericality_of(:rank).only_integer.allow_nil }
  it { should validate_numericality_of(:inventory).only_integer.allow_nil }

  it { should define_enum_for(:status).with(%i[pending fetching ready]) }
  it { should define_enum_for(:last_fetch_status).with(%i[unknown success error]) }

  describe 'Callbacks' do
    it '#enqueue_fetcher' do
      allow(subject).to receive(:previous_changes).and_return(asin: true)
      expect(ProductFetcherJob).to receive(:perform_later)
      subject.send(:enqueue_fetcher)
    end

    describe '#enqueue_notification' do
      it 'no changes on notificable attributes' do
        allow(subject).to receive(:previous_changes).and_return(updated_at: Time.now)
        expect(ProductUpdateNotificationJob).to_not receive(:perform_later)
        subject.send(:enqueue_notification)
      end

      %i[features images inventory price rank reviews_count title].each do |attr|
        it "#{attr} changed" do
          allow(subject).to receive(:previous_changes).and_return(attr => true)
          expect(ProductUpdateNotificationJob).to receive(:perform_later)
          subject.send(:enqueue_notification)
        end
      end
    end
  end
end
