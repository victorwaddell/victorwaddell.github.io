class CreateItemPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :item_prices do |t|
      t.float :price
      t.date :start_date
      t.date :end_date
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
