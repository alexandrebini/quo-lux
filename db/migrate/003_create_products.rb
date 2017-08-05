class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :asin, null: false
      t.string :title, null: false
      t.integer :price, null: false, default: 0
      t.string :images, null: false, array: true, default: []
      t.string :features, null: false, array: true, default: []
      t.integer :reviews_count, null: false, default: 0
      t.integer :rank, null: false, default: 0
      t.integer :inventory, null: false, default: 0
      t.string :slug, null: false
      t.timestamps null: false
    end
    add_index :products, :asin, unique: true
    add_index :products, :slug, unique: true
    add_index :products, :price
    add_index :products, :rank
    add_index :products, :reviews_count
  end
end
