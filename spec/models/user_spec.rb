require 'rails_helper'

RSpec.describe User do
  it { should have_db_column(:email).with_options(null: false, default: '') }
  it { should have_db_column(:encrypted_password).with_options(null: false, default: '') }
  it { should have_db_column(:reset_password_token) }
  it { should have_db_column(:reset_password_sent_at) }
  it { should have_db_column(:remember_created_at) }
  it { should have_db_column(:updated_at).with_options(null: false) }
  it { should have_db_index(:email).unique(true) }
  it { should have_db_index(:reset_password_token).unique(true) }

  it { should have_many(:groups).dependent(:destroy) }

  describe '#validates max groups' do
    let(:max_count) { Validators::MaxGroupsPerUserValidator::MAX_GROUPS_PER_USER }
    context 'below max count' do
      let(:user) { build(:user, groups: build_list(:group, max_count)) }
      it { expect(user.valid?).to be_truthy }
    end

    context 'above max count' do
      let(:user) { build(:user, groups: build_list(:group, max_count + 1)) }
      it { expect(user.valid?).to be_falsey }
    end
  end
end
