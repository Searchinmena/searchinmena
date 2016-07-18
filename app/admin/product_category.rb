ActiveAdmin.register ProductCategory do
  menu parent: 'Manage Category'
  permit_params :parent_id, :meta_title, :meta_keywords, :meta_description,
                translations_attributes: [:id, :locale, :value]

  filter :id
  filter :parent_id, as: :numeric
  filter :translations

  index do
    selectable_column
    id_column
    column :parent_id
    column 'Parent' do |category|
      if category.parent
        category.parent.english_title
      end
    end
    column 'Title' do |category|
      category.translations.pluck(:value).join('  ')
    end
    column :meta_title
    column :meta_keywords
    column :meta_description
    actions
  end

  show do
    attributes_table do
      row :id
      row 'Parent' do |category|
        if category.parent
          category.parent.english_title
        end
      end
      row 'English Title' do |category|
        category.translations.where(locale: 'en').pluck(:value).join('  ')
      end

      row 'Arabic Title' do |category|
        category.translations.where(locale: 'ar').pluck(:value).join('  ')
      end
      row :meta_title
      row :meta_keywords
      row :meta_description
    end
  end
  form do |f|
    semantic_errors # shows errors on :base
    f.inputs do
      f.input :parent_id, as: :select, collection:
      ProductCategory.all.map { |c| [c.english_title, c.id] }
      f.has_many :translations do |translation|
        translation.input :locale,
                          label: 'Language',
                          as: :select, collection:
                          CategoryTranslation::LOCALE.collect { |l| [l, l] }
        translation.input :value,
                          label: 'Title',
                          input_html: { rows: 1 }
      end
      f.input :meta_title
      f.input :meta_keywords
      f.input :meta_description
      actions # adds the 'Submit' and 'Cancel' buttons
    end
  end
end