class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :client_id
      t.integer :payment_date
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :job
      t.string :country
      t.string :address
      t.string :zip_code
      t.string :phone

      t.timestamps
    end
  end
end
