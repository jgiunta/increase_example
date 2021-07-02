json.transactions do
  @payments.each do |payment|
    payment.transactions.each do |transaction|
      json.id transaction.transaction_id
      json.amount transaction.amount
      json.kind transaction.kind
      json.payment_id transaction.payment_id
    end
  end
end
