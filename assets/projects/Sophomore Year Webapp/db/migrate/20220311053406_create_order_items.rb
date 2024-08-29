class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.date :shipped_on
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
