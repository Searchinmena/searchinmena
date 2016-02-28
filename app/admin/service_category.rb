ActiveAdmin.register ServiceCategory do
  menu parent: 'Manage Category'
  permit_params :parent_id

  index do
    selectable_column
    id_column
    column 'Parent' do |category|
      category.parent.translations.where(locale: 'en').pluck(:value).join(" ") if category.parent
    end
    column 'Title' do |category|
      category.translations.pluck(:value).join('        ')
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row 'Parent' do |category|
      category.parent.translations.where(locale: 'en').pluck(:value).join(" ")  if category.parent
    end
      row 'English Title' do |category|
        category.translations.where(locale: 'en').pluck(:value).join('  ')
      end

      row 'Arabic Title' do |category|
        category.translations.where(locale: 'ar').pluck(:value).join('  ')
      end
    end
    active_admin_comments
  end

  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :parent_id, as: :select, collection:
      ServiceCategory.all.map { |c| [c.translations.where(locale: 'en').pluck(:value).join(' '), c.id] }
     
      f.has_many :translations do |translation|
        translation.input :locale, 
                          label: 'Language',
                          as: :select, 
                          collection: CategoryTranslation::LOCALE.collect { |locale| [locale, locale] }
        translation.input :value, 
                          label: 'Title',
                          input_html: { rows: 1 }
      end
      actions         # adds the 'Submit' and 'Cancel' buttons
    end
  end
end
