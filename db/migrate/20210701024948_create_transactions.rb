class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.integer :amount
      t.integer :kind
      t.belongs_to :payment, foreign_key: true

      t.timestamps
    end
  end
end
