module BusinessItemPaymentTermRepository
  def delete_other_than(business_item, ids)
    relation = for_business_item(business_item)
    if ids.empty?
      relation.delete_all
    else
      relation.where("payment_term_id not in (?)", ids).delete_all
    end
  end
end
