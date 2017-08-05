require 'rails_helper'

RSpec.describe Group do
  it { should have_db_column(:user_id).with_options(null: false) }
  it { should have_db_column(:name).with_options(null: false) }
  it { should have_db_column(:updated_at).with_options(null: false) }
  it { should have_db_index(:user_id) }
  it { should have_db_index(:slug).unique(true) }

  it { should belong_to(:user) }
  it { should have_many(:competitors).dependent(:destroy) }
  it { should have_many(:products).through(:competitors) }

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }

    describe '#validates max groups per user' do
      let(:max_count) { Validators::MaxGroupsPerUserValidator::MAX_GROUPS_PER_USER }
      let(:user) { create(:user) }

      context 'below max count' do
        before { (max_count - 1).times { create(:group, user: user) } }
        it { expect { create(:group, user: user) }.to_not raise_error }
      end
      context 'above max count' do
        before { max_count.times { create(:group, user: user) } }
        it { expect { create(:group, user: user) }.to raise_error(ActiveRecord::RecordInvalid) }
      end
    end

    describe '#validates max competitors per group' do
      let(:max_count) { Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP }
      context 'below max count' do
        let(:group) { build(:group, competitors: build_list(:competitor, max_count)) }
        it { expect(group.valid?).to be_truthy }
      end
      context 'above max count' do
        let(:group) { build(:group, competitors: build_list(:competitor, max_count + 1)) }
        it { expect(group.valid?).to be_falsey }
      end
    end
  end
end
