class CreateProductPaymentTerms < ActiveRecord::Migration
  def change
    create_table :product_payment_terms do |t|
      t.integer :product_id, null: false, index: true
      t.integer :payment_term_id, null: false, index: true

      t.timestamps null: false
    end

    add_index :product_payment_terms, [:product_id, :payment_term_id], unique: true
  end
end
