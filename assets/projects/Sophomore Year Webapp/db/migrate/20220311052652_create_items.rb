class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :color
      t.integer :inventory_level
      t.integer :reorder_level
      t.float :weight
      t.boolean :is_featured
      t.boolean :active
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
