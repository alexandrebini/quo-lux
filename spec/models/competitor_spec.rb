require 'rails_helper'

RSpec.describe Competitor do
  it { should have_db_column(:group_id).with_options(null: false) }
  it { should have_db_column(:product_id).with_options(null: false) }
  it { should have_db_column(:updated_at).with_options(null: false) }
  it { should have_db_index(%i[group_id product_id]) }
  it { should have_db_index(%i[product_id group_id]) }

  it { should belong_to(:group) }
  it { should belong_to(:product) }
  it { should have_one(:user).through(:group) }

  describe 'validations' do
    it { should validate_presence_of(:group) }
    it { should validate_presence_of(:product) }

    describe '#validates max competitions per group' do
      let(:max_count) { Validators::MaxCompetitorsPerGroupValidator::MAX_COMPETITORS_PER_GROUP }
      let(:group) { create(:group) }

      context 'below max count' do
        before { (max_count - 1).times { create(:competitor, group: group) } }
        it { expect { create(:competitor, group: group) }.to_not raise_error }
      end

      context 'above max count' do
        before { max_count.times { create(:competitor, group: group) } }
        it do
          expect { create(:competitor, group: group) }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
