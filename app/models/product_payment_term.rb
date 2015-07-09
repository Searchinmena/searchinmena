class ProductPaymentTerm < ActiveRecord::Base
  belongs_to :product
  belongs_to :payment_term
end
