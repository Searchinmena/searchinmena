class CreateServicePaymentTerms < ActiveRecord::Migration
  def change
    create_table :service_payment_terms do |t|
      t.integer :service_id, null: false, index: true
      t.integer :payment_term_id, null: false, index: true

      t.timestamps null: false
    end

    add_index :service_payment_terms, [:service_id, :payment_term_id], unique: true
  end
end
