json.extract! transaction, :id, :transaction_id, :amount, :kind, :payment_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
