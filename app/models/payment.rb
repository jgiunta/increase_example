class Payment < ApplicationRecord
  belongs_to :client
  has_many :transactions
  has_many :discounts
end
