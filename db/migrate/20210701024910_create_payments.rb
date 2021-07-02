class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :payment_id
      t.integer :coin
      t.integer :total_amount
      t.integer :total_discount
      t.integer :total_with_discounts
      t.belongs_to :client, foreign_key: true

      t.timestamps
    end
  end
end
