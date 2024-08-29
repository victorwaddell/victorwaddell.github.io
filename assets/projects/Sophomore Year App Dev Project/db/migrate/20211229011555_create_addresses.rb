class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :recipient
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :active, default: true
      t.references :customer, foreign_key: true
      t.boolean :is_billing, default: false

      # t.timestamps
    end
  end
end
