class AddStatusOnProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :status, :integer, null: false, default: 0
    add_column :products, :last_fetch_at, :datetime
    add_column :products, :last_fetch_status, :integer, null: false, default: 0
    add_column :products, :last_fetch_log, :text
    add_index :products, :status
    add_index :products, :last_fetch_status

    change_column :products, :price, :integer, null: true, default: nil
    change_column :products, :title, :string, null: true
    change_column :products, :reviews_count, :integer, null: true, default: nil
    change_column :products, :rank, :integer, null: true, default: nil
    change_column :products, :inventory, :integer, null: true, default: nil
  end
end
