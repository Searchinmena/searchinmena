ActiveAdmin.register ServiceCategory do
  permit_params :parent_id
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :parent_id, as: :select, collection:
      Category.all.map { |c| [c.id, c.id] }
    end
    actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
