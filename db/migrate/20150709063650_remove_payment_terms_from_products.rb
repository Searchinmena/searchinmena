class RemovePaymentTermsFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :payment_terms
  end

  def down
    add_column :products, :payment_terms, :string
  end
end
