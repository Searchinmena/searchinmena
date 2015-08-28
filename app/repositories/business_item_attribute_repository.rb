module BusinessItemAttributeRepository
  def to_update(business_item, attributes_params)
    groupped = Hash[attributes_params.map { |o| [o[:id], o.except(:id)] }]

    ids_to_update = groupped.keys
    to_update = for_business_item(business_item)
      .where("id in (?)", ids_to_update)

    to_update.map do |attribute|
      [attribute, groupped[attribute.id]]
    end
  end

  def delete_other_than(business_item, ids)
    relation = for_business_item(business_item)
    if ids.empty?
      relation.delete_all
    else
      relation.where("id not in (?)", ids).delete_all
    end
  end
end
