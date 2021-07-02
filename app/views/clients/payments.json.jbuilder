json.collected do
  @payments_collected.each do |collected|
    json.payment_id collected.payment_id
    json.coin collected.coin
    json.total_amount collected.total_amount
    json.total_discount collected.total_discount
    json.total_with_discounts collected.total_with_discounts
    json.payment_date collected.payment_date
  end
end

json.receivable do
  @payments_receivable.each do |receivable|
    json.payment_id receivable.payment_id
    json.coin receivable.coin
    json.total_amount receivable.total_amount
    json.total_discount receivable.total_discount
    json.total_with_discounts receivable.total_with_discounts
    json.payment_date receivable.payment_date
  end
end
