class ProductCategory < Category
  searchkick text_start: [:name]
end
