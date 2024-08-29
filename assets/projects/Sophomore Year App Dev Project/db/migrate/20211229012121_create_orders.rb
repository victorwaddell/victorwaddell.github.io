class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :address, foreign_key: true
      t.date :date
      t.float :products_total
      t.float :shipping
      t.string :payment_receipt

      # t.timestamps
    end
  end
end
