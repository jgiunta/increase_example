class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :discount_id
      t.integer :amount
      t.integer :kind
      t.belongs_to :payment, foreign_key: true

      t.timestamps
    end
  end
end
