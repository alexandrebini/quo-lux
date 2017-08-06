class AddProductIdOnGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :product_id, :integer, null: false
    add_index :groups, :product_id
  end
end
