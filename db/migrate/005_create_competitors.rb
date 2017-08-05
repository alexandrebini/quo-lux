class CreateCompetitors < ActiveRecord::Migration[5.1]
  def change
    create_table :competitors do |t|
      t.integer :group_id, null: false
      t.integer :product_id, null: false
      t.timestamps null: false
    end
    add_index :competitors, %i[group_id product_id]
    add_index :competitors, %i[product_id group_id]
  end
end
