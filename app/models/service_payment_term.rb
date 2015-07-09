class ServicePaymentTerm < ActiveRecord::Base
  belongs_to :service
  belongs_to :payment_term
end
