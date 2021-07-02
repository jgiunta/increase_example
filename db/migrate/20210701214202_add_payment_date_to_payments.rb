class AddPaymentDateToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :payment_date, :date
    remove_column :clients, :payment_date
  end
end
