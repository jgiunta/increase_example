json.extract! payment, :id, :payment_id, :coin, :total_amount, :total_discount, :total_with_discounts, :client_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
