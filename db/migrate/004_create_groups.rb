class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :slug, null: false
      t.timestamps null: false
    end
    add_index :groups, :user_id
    add_index :groups, :slug, unique: true
  end
end
