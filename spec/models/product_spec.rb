require 'rails_helper'

RSpec.describe Product do
  it { should have_db_column(:asin).with_options(null: false) }
  it { should have_db_column(:created_at).with_options(null: false) }
  it { should have_db_column(:features).with_options(null: false, default: []) }
  it { should have_db_column(:images).with_options(null: false, default: []) }
  it { should have_db_column(:inventory).with_options(null: false, default: 0) }
  it { should have_db_column(:price).with_options(null: false, default: 0) }
  it { should have_db_column(:rank).with_options(null: false, default: 0) }
  it { should have_db_column(:reviews_count).with_options(null: false, default: 0) }
  it { should have_db_column(:slug).with_options(null: false) }
  it { should have_db_column(:title).with_options(null: false) }
  it { should have_db_column(:updated_at).with_options(null: false) }
  it { should have_db_index(:asin).unique(true) }
  it { should have_db_index(:price) }
  it { should have_db_index(:rank) }
  it { should have_db_index(:reviews_count) }
  it { should have_db_index(:slug).unique(true) }

  it { should have_many(:competitors).dependent(:destroy) }

  it { should validate_presence_of(:asin) }
  it { should validate_presence_of(:inventory) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:rank) }
  it { should validate_presence_of(:reviews_count) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:asin) }
  it { should validate_numericality_of(:price).only_integer }
  it { should validate_numericality_of(:reviews_count).only_integer }
  it { should validate_numericality_of(:rank).only_integer }
  it { should validate_numericality_of(:inventory).only_integer }
end
